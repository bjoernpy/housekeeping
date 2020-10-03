import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// ignore: unused_import
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'package:housekeeping/routes.dart';
import 'package:housekeeping/themes/style.dart';

FirebaseAnalytics analytics;

Future<void> main() async {
  // First initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Add Firebase Analytics
  analytics = FirebaseAnalytics();

  // Configure Firebase Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    // Disable all Analytics during the debug Mode
    await analytics.setAnalyticsCollectionEnabled(false);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
  }

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My household',
      theme: AppTheme.darkTheme,
      initialRoute: "/",
      onGenerateRoute: Router.generateRoute,
    );
  }
}
