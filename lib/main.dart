import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/app_config.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id_ID';
  await initializeDateFormatting('id_ID');
  if (appBackend == AppBackend.firebase) {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      // If not configured, keep running with local backend.
      debugPrint('Firebase initialization skipped/failed: $e');
    }
  }
  runApp(const ProviderScope(child: App()));
}
