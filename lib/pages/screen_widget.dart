import 'package:decentralised_medical_records/auth/credential_check.dart';
import 'package:decentralised_medical_records/pages/home_page.dart';
import 'package:decentralised_medical_records/pages/records_page.dart';
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
      navigationSettings: RailAndBottomSettings(
        pages: <Widget>[HomePage(),RecordsPage(),Placeholder()],
        destinations: [
          DestinationModel(
            label: 'Home',
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_filled),
            tooltip: 'Home page',
          ),
          DestinationModel(
            label: 'Records',
            icon: const Icon(Icons.note_alt_outlined),
            selectedIcon: const Icon(Icons.note_alt_rounded),
            tooltip: 'Add Records',
          ),
          DestinationModel(
            label: 'Settings',
            icon: const Icon(Icons.message_outlined),
            selectedIcon: const Icon(Icons.message),
            tooltip: 'Settings',
          ),
        ],
        showMenuIcon: false,
        groupAlignment: -1.0,
        labelType: NavigationRailLabelType.all,
      ),
    );
    ;
  }
}
