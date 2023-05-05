import 'package:decentralised_medical_records/credential_check.dart';
import 'package:decentralised_medical_records/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true, // HERE!
      ),
      darkTheme: ThemeData(
        useMaterial3: true, // HERE!
      ),
      themeMode: ThemeMode.dark,
      home: const CredentialLogin(),
    );
  }
}
