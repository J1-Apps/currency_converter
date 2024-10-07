import "package:currency_converter/app.dart";
import "package:currency_converter/repository/local_repository_config.dart";
import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/util/environment/local_environment.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Currency Converter App", () {
    testWidgets("builds and displays the home page", (tester) async {
      await LocalEnvironment().configure();
      await tester.pumpWidget(CurrencyConverterApp());
      await tester.pumpAndSettle(const Duration(milliseconds: LocalRepositoryConfig.mockNetworkDelayMs));

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
