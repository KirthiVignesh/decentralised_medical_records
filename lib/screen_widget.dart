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
        pages: <Widget>[],
        destinations: [
          DestinationModel(
            label: 'Home',
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_filled),
            tooltip: 'Home page',
          ),
          DestinationModel(
            label: 'Records',
            icon: const Icon(Icons.group_outlined),
            selectedIcon: const Icon(Icons.group),
            tooltip: 'Add Records',
          ),
          DestinationModel(
            label: 'Ambulance',
            badge: Badge.count(
              count: 125,
              child: const Icon(Icons.message_outlined),
            ),
            selectedIcon: const Icon(Icons.message),
            tooltip: 'Ambulance',
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
