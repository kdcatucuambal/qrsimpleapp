import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", false, ScanMode.QR);

          print(barcodeScanRes);

          if (barcodeScanRes == '-1') return;

          if (!mounted) return;
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          final newScan = await scanListProvider.create(value: barcodeScanRes);

          if (!mounted) return;
          launchUrlInWebView(context, newScan);
        },
        child: const Icon(Icons.filter_center_focus));
  }
}
