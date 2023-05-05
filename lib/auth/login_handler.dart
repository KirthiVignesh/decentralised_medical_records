import 'package:decentralised_medical_records/auth/form_wallet.dart';
import 'package:decentralised_medical_records/auth/route_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:decentralised_medical_records/auth/auth_page.dart';
import 'package:decentralised_medical_records/pages/screen_widget.dart';

class LoginHandler extends StatefulWidget {
  const LoginHandler({super.key});

  @override
  State<LoginHandler> createState() => _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.idTokenChanges(),
          builder: (context, snapshot) {
            //print(snapshot.hasData);
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (snapshot.hasData) {
                return RouteKYC();
              } else {
                return AuthPage();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
