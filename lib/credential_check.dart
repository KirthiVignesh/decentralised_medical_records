import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialLogin extends StatefulWidget {
  const CredentialLogin({super.key});

  @override
  State<CredentialLogin> createState() => _CredentialLoginState();
}

class _CredentialLoginState extends State<CredentialLogin> {
  String? _privateKey;
  final storage = const FlutterSecureStorage();
  final _mnemonicController = TextEditingController();
  void getUserName() async {
    _privateKey = await storage.read(key: '_privateKey');
  }

  void dispose() {
    _mnemonicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            getUserName();
          },
          child: Text("Tap to retreive private key from the local store"),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: _mnemonicController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: '24 word mnemonic',
                  filled: true),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            getUserName();
          },
          child: Text("Tap to generate new key"),
        ),
      ],
    );
  }
}
