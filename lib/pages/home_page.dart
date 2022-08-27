import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/address_page.dart';
import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('History'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAll();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //backgroundColor: Colors.white,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (uiProvider.selectedMenuOpt) {
      case 0:
        scanListProvider.getByType('geo');
        return const MapsPage();
      case 1:
        scanListProvider.getByType('http');
        return const AddressPage();
      default:
        return const MapsPage();
    }
  }
}
