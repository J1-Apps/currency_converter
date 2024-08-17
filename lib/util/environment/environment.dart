import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

GetIt locator = GetIt.instance;

// coverage:ignore-file
abstract class Environment {
  FirebaseOptions? get firebaseOptions;

  Future<void> configure({
    FirebaseOptions? firebaseOptions,
  }) async {
    final options = firebaseOptions ?? this.firebaseOptions;

    WidgetsFlutterBinding.ensureInitialized();

    if (options != null) {
      await Firebase.initializeApp(options: options);
    }

    // // Utilities.
    // FlutterError.onError = crashHandler?.handleFlutterError ?? this.crashHandler.handleFlutterError;
    // PlatformDispatcher.instance.onError = crashHandler?.handleAsyncError ?? this.crashHandler.handleAsyncError;
    // locator.registerSingleton<NotedLogger>(logger ?? this.logger);
    // locator.registerSingleton<NotedRouter>(router ?? this.router);

    // // Repositories.
    // locator.registerSingleton<AuthRepository>(authRepository ?? this.authRepository);
    // locator.registerSingleton<SettingsRepository>(settingsRepository ?? this.settingsRepository);
    // locator.registerSingleton<NotesRepository>(notebookRepository ?? this.notebookRepository);
    // locator.registerSingleton<OgpRepository>(ogpRepository ?? this.ogpRepository);
  }
}
