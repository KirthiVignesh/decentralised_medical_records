import 'package:flutter/material.dart';
import 'package:material3_layout/material3_layout.dart';

class ScreenWidget extends StatefulWidget {
  const ScreenWidget({super.key});

  @override
  State<ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  @override
  Widget build(BuildContext context) {
      return NavigationScaffold(
      theme: Theme.of(context),
      navigationType: NavigationTypeEnum.railAndBottomNavBar,
      navigationSettings: ,
      onDestinationSelected: (int index) => ,
    );;
  }
}