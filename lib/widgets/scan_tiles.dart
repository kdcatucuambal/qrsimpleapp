import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: true);
    final scans = scanListProvider.scans;
    print(
        'Scan tiles ejecuting $type, provider: ${scanListProvider.typeSelected}');

    if (type == scanListProvider.typeSelected) {
      return ListView.builder(
          itemCount: scanListProvider.scans.length,
          itemBuilder: (_, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.redAccent,
                child: const Center(
                  child: Text('Deleting...',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              onDismissed: (direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteById(scans[index].id!);
              },
              child: ListTile(
                leading: Icon(
                    type == 'http' ? Icons.compass_calibration : Icons.map,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[index].value),
                subtitle: Text(scans[index].id.toString()),
                trailing:
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => launchUrlInWebView(context, scans[index]),
              ),
            );
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
