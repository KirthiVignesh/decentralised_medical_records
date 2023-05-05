import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decentralised_medical_records/auth/form_wallet.dart';
import 'package:decentralised_medical_records/pages/screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:decentralised_medical_records/auth/form_wallet.dart';

class RouteKYC extends StatefulWidget {
  const RouteKYC({super.key});

  @override
  State<RouteKYC> createState() => _RouteKYCState();
}

class _RouteKYCState extends State<RouteKYC> {
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    String? uid = auth.currentUser?.uid;
    if (uid == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => BasicInfo()));
    } else {
      db.collection('customer').doc(uid).get().then((DocumentSnapshot doc) {
        //print(user!.entries.length);
        if (doc.exists) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ScreenWidget()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => BasicInfo()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
