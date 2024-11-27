import "package:currency_converter/state/favorites/favorites_bloc.dart";
import "package:currency_converter/state/favorites/favorites_event.dart";
import "package:currency_converter/state/favorites/favorites_state.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/favorites/favorites_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/rxdart.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

final _favoritesState = FavoritesState.loaded(
  favorites: testFavorites0,
  nonFavorites: testCurrencies0.where((code) => !testFavorites0.contains(code)).toList(),
);

void main() {
  group("Favorites Screen", () {
    final FavoritesBloc bloc = MockFavoritesBloc();
    final router = MockRouter();
    late BehaviorSubject<FavoritesState> stateController;

    setUpAll(() {
      locator.registerSingleton<J1Router>(router);

      registerFallbackValue(const FavoritesLoadEvent());
      registerFallbackValue(FakeBuildContext());
    });

    setUp(() {
      stateController = BehaviorSubject<FavoritesState>.seeded(_favoritesState);

      when(() => bloc.stream).thenAnswer((_) => stateController.stream);
      when(() => bloc.state).thenAnswer((_) => stateController.value);
      when(() => bloc.add(any())).thenAnswer((_) => Future.value());
      when(bloc.close).thenAnswer((_) => Future.value());

      when(() => router.navigate(any(), any())).thenAnswer((_) => Future.value());
      when(() => router.canPop(any())).thenAnswer((_) => true);
      when(() => router.pop(any())).thenAnswer((_) => Future.value());
    });

    tearDown(() {
      reset(bloc);
      reset(router);
      stateController.close();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    group("error messages", () {
      testWidgets("shows load favorites error message", (tester) async {
        await tester.pumpWidget(_TestWidget(bloc));

        stateController.add(_favoritesState.copyWith(error: FavoritesErrorCode.loadFavorites));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets("shows save favorite error message", (tester) async {
        await tester.pumpWidget(_TestWidget(bloc));

        stateController.add(_favoritesState.copyWith(error: FavoritesErrorCode.saveFavorite));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets("shows load currencies error message", (tester) async {
        await tester.pumpWidget(_TestWidget(bloc));

        stateController.add(_favoritesState.copyWith(error: FavoritesErrorCode.loadCurrencies));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });

      group("user flows", () {
        testWidgets("navigates back", (tester) async {
          await tester.pumpWidget(_TestWidget(bloc));
          await tester.tap(find.byIcon(JamIcons.chevronleft));
          await tester.pumpAndSettle();

          verify(() => router.pop(any())).called(1);
        });

        testWidgets("filters and toggles currencies", (tester) async {
          tester.view.physicalSize = const Size(720, 2000);
          tester.view.devicePixelRatio = 1.0;

          addTearDown(() => tester.view.resetPhysicalSize());
          addTearDown(() => tester.view.resetDevicePixelRatio());

          await tester.pumpWidget(_TestWidget(bloc));

          final searchFinder = find.byType(JTextField);
          final cardFinder = find.byType(SelectCurrencyCard);
          expect(searchFinder, findsOneWidget);
          expect(cardFinder, findsAtLeastNWidgets(1));

          await tester.enterText(searchFinder, "invalid filter");
          await tester.pumpAndSettle();

          expect(cardFinder, findsNothing);

          await tester.enterText(searchFinder, "");
          await tester.pumpAndSettle();

          await tester.enterText(searchFinder, "usd");
          await tester.pumpAndSettle();

          expect(cardFinder, findsOneWidget);

          await tester.enterText(searchFinder, "");
          await tester.pumpAndSettle();

          await tester.tap(cardFinder.at(0));
          await tester.tap(cardFinder.at(2));
          verify(() => bloc.add(any(that: isInstanceOf<FavoritesToggleEvent>()))).called(2);
        });
      });
    });
  });
}

class _TestWidget extends StatelessWidget {
  final FavoritesBloc bloc;

  const _TestWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TestWrapper<FavoritesBloc>(
      globalBloc: bloc,
      child: const Scaffold(body: FavoritesScreen()),
    );
  }
}
