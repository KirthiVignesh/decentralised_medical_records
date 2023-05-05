import 'dart:io';
import 'dart:math';

import 'package:decentralised_medical_records/screen_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web3dart/web3dart.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialLogin extends StatefulWidget {
  const CredentialLogin({super.key});

  @override
  State<CredentialLogin> createState() => _CredentialLoginState();
}

class _CredentialLoginState extends State<CredentialLogin> {
  String? _privateKey;

  final _passwordController = TextEditingController();
  Future<void> getUserKey() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
   
  // String? content = File(result!.files.single.path!).readAsStringSync();
   final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;
   String content=File('$_path/wallet.json').readAsStringSync();
Wallet wallet = Wallet.fromJson(content, "password");
print(wallet.privateKey.address);
 Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const ScreenWidget(),
    ),
  );
  }
  Future<void> generateUserKey() async {
var cred = EthPrivateKey.createRandom(Random.secure());
//  storage.write(key: '_privateKey',value: random.extractAddress());
 Wallet wallet = Wallet.createNew(cred, "password",Random.secure() );
 print(wallet.toString());
 final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;
    File('$_path/wallet.json').writeAsString(wallet.toJson());
    Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const ScreenWidget(),
    ),
  );
  }

  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            SizedBox(height: 30),

            //password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async {await getUserKey();},
                  
                    
                  child: Text('Select wallet file from local storage'),
                ),
              ),
            ),
            SizedBox(height: 10),
            //sign-in
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async {await generateUserKey();},
                  
                    
                  child: Text('Generate new user-key'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
           
          ],
        ),
      ))),
    );
  }
}
