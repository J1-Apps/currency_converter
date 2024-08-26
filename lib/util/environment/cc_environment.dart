import "package:j1_environment/j1_environment.dart";
import "package:j1_theme/j1_theme.dart";

abstract class CcEnvironment extends J1Environment {
  J1ThemeRepository get themeRepository;

  @override
  Future<void> configure() async {
    await super.configure();

    locator.registerSingleton<J1ThemeRepository>(themeRepository);
  }
}
