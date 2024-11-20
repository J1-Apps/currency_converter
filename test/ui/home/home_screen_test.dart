import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:currency_converter/ui/home/home_error.dart";
import "package:currency_converter/ui/home/home_loading.dart";
import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/subjects.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

final _homeState = HomeState.fromValues(
  configuration: testConfig0,
  exchange: testSnapshot0,
  favorites: testFavorites0,
  currencies: testCurrencies1,
);

void main() {
  group("Home Screen", () {
    final HomeBloc homeBloc = MockHomeBloc();
    final events = <HomeEvent>[];
    late BehaviorSubject<HomeState> stateController;

    setUpAll(() {
      registerFallbackValue(const HomeLoadEvent());
    });

    setUp(() {
      stateController = BehaviorSubject<HomeState>.seeded(_homeState);

      when(() => homeBloc.stream).thenAnswer((_) => stateController.stream);
      when(() => homeBloc.state).thenAnswer((_) => stateController.value);
      when(() => homeBloc.add(any())).thenAnswer((_) => Future.value());
      when(homeBloc.close).thenAnswer((_) => Future.value());
    });

    tearDown(() {
      reset(homeBloc);
      events.clear();
      stateController.close();
    });

    group("static flows", () {
      testWidgets("shows loading screen, then refresh and settings buttons", (tester) async {
        stateController.add(const HomeState.loading());

        await tester.pumpWidget(_TestWidget(homeBloc));

        expect(find.byType(HomeLoading), findsOneWidget);

        stateController.add(_homeState);
        await tester.pumpAndSettle();

        expect(find.byIcon(JamIcons.refresh), findsOneWidget);
        expect(find.byIcon(JamIcons.settings), findsOneWidget);
      });

      testWidgets("shows error screen", (tester) async {
        stateController.add(const HomeState.error());

        await tester.pumpWidget(_TestWidget(homeBloc));

        expect(find.byType(HomeError), findsOneWidget);

        await tester.tap(find.byType(JTextButton));

        verify(() => homeBloc.add(const HomeLoadEvent())).called(1);

        stateController.add(_homeState);
        await tester.pumpAndSettle();

        expect(find.byIcon(JamIcons.refresh), findsOneWidget);
        expect(find.byIcon(JamIcons.settings), findsOneWidget);
      });

      testWidgets("shows refresh error", (tester) async {
        stateController.add(_homeState.copyWith(refresh: null));

        await tester.pumpWidget(_TestWidget(homeBloc));

        expect(find.text("Refresh error"), findsOneWidget);
      });
    });

    group("error messages", () {});

    group("user flows", () {
      testWidgets("navigates to settings", (tester) async {
        locator.registerSingleton<J1Router>(GoRouter());

        await tester.pumpWidget(
          BlocProvider(
            create: (_) => homeBloc,
            child: MaterialApp.router(
              localizationsDelegates: Strings.localizationsDelegates,
              supportedLocales: Strings.supportedLocales,
              routerConfig: routeGraph.buildConfig(),
            ),
          ),
        );
        await tester.tap(find.byIcon(JamIcons.settings));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsScreen), findsOneWidget);

        await locator.reset();
      });

      testWidgets("refreshes the page", (tester) async {
        await tester.pumpWidget(_TestWidget(homeBloc));

        await tester.tap(find.byIcon(JamIcons.refresh));
        stateController.add(
          stateController.value.copyWith(refresh: stateController.value.refresh?.copyWith(isRefreshing: true)),
        );

        await tester.pump();

        verify(() => homeBloc.add(const HomeRefreshEvent())).called(1);
        expect(find.byType(JLoadingIndicator), findsOneWidget);
      });

      testWidgets("changes the base currency value", (tester) async {
        await tester.pumpWidget(_TestWidget(homeBloc));
        await tester.enterText(find.byType(JTextField).first, "200");
        await tester.pumpAndSettle();

        verify(() => homeBloc.add(any(that: isInstanceOf<HomeUpdateBaseValueEvent>()))).called(1);
      });

      testWidgets("changes the converted currency value", (tester) async {
        await tester.pumpWidget(_TestWidget(homeBloc));
        await tester.enterText(find.byType(JTextField).last, "200");
        await tester.pumpAndSettle();

        verify(() => homeBloc.add(any(that: isInstanceOf<HomeUpdateBaseValueEvent>()))).called(1);
      });

      testWidgets("expands a currency, favorites, and removes", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(homeBloc));
        await tester.tap(find.byIcon(JamIcons.info).first);

        stateController.add(
          stateController.value.copyWith(
            currencies: [
              ...(stateController.value.currencies?.indexed ?? []).map(
                (pair) => pair.$1 == 0 ? pair.$2.copyWith(isExpanded: true) : pair.$2,
              ),
            ],
          ),
        );

        await tester.pumpAndSettle();

        final expandedFinder = find.byIcon(JamIcons.infofilled);
        final favoriteFinder = find.byIcon(JamIcons.starfilled);
        final notFavoriteFinder = find.byIcon(JamIcons.star);
        final removeFinder = find.byIcon(JamIcons.trash);

        expect(expandedFinder, findsOneWidget);
        expect(favoriteFinder, findsNothing);
        expect(notFavoriteFinder, findsOneWidget);
        expect(removeFinder, findsOneWidget);

        await tester.tap(notFavoriteFinder);

        stateController.add(
          stateController.value.copyWith(
            currencies: [
              ...(stateController.value.currencies?.indexed ?? []).map(
                (pair) => pair.$1 == 0 ? pair.$2.copyWith(isFavorite: true) : pair.$2,
              ),
            ],
          ),
        );

        await tester.pumpAndSettle();

        verify(() => homeBloc.add(any(that: isInstanceOf<HomeToggleFavoriteEvent>()))).called(1);
        expect(expandedFinder, findsOneWidget);
        expect(favoriteFinder, findsOneWidget);
        expect(notFavoriteFinder, findsNothing);
        expect(removeFinder, findsOneWidget);

        await tester.tap(removeFinder);

        final currencies = [...stateController.value.currencies ?? <HomeConvertedCurrency>[]];
        currencies.removeAt(0);
        stateController.add(stateController.value.copyWith(currencies: currencies));

        await tester.pumpAndSettle();

        verify(() => homeBloc.add(any(that: isInstanceOf<HomeToggleCurrencyEvent>()))).called(1);
        expect(expandedFinder, findsNothing);
        expect(favoriteFinder, findsNothing);
        expect(notFavoriteFinder, findsNothing);
        expect(removeFinder, findsNothing);
      });

      testWidgets("adds a currency through the selector drawer", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(homeBloc));

        expect(find.byType(CurrencyCard), findsNWidgets(3));

        await tester.tap(find.byIcon(JamIcons.plus));
        await tester.pumpAndSettle();

        final cardFinder = find.byType(SelectCurrencyCard);

        expect(find.byType(SelectCurrencyDrawer), findsOneWidget);
        expect(cardFinder, findsNWidgets(4));

        await tester.tap(cardFinder.at(2));
        verify(() => homeBloc.add(any(that: isInstanceOf<HomeToggleCurrencyEvent>()))).called(1);
        stateController.add(
          stateController.value.copyWith(
            currencies: [
              ...stateController.value.currencies ?? [],
              const HomeConvertedCurrency(code: CurrencyCode.MXN, value: 1.0, isFavorite: false, isExpanded: false),
            ],
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(CurrencyCard), findsNWidgets(4));
      });

      testWidgets("changes base currency", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(homeBloc));
        await tester.tap(find.text("USD"));
        await tester.pumpAndSettle();

        final cardFinder = find.byType(SelectCurrencyCard);

        expect(find.byType(SelectCurrencyDrawer), findsOneWidget);
        expect(cardFinder, findsNWidgets(4));

        await tester.tap(cardFinder.at(0));
        verify(() => homeBloc.add(any(that: isInstanceOf<HomeUpdateBaseCurrencyEvent>()))).called(1);
      });

      testWidgets("changes converted currency", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(homeBloc));
        await tester.tap(find.text("KRW"));
        await tester.pumpAndSettle();

        final cardFinder = find.byType(SelectCurrencyCard);

        expect(find.byType(SelectCurrencyDrawer), findsOneWidget);
        expect(cardFinder, findsNWidgets(2));

        await tester.tap(cardFinder.at(0));
        verify(() => homeBloc.add(any(that: isInstanceOf<HomeUpdateCurrencyEvent>()))).called(1);
      });
    });
  });
}

class _TestWidget extends StatelessWidget {
  final HomeBloc bloc;

  const _TestWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TestWrapper<HomeBloc>(
      globalBloc: bloc,
      child: const HomeScreen(),
    );
  }
}
