import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: true);
    return BottomNavigationBar(
        currentIndex: uiProvider.selectedMenuOpt,
        elevation: 8,
        onTap: (index) {
          uiProvider.selectedMenuOpt = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Address')
        ]);
  }
}
