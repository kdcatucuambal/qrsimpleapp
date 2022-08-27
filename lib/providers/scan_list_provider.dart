import 'package:flutter/widgets.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> create({required String value}) async {
    final scan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(scan);
    scan.id = id;
    if (typeSelected == scan.type) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  void getAll() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  void getByType(String type) async {
    print('getting by type: $type');
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    typeSelected = type;
    notifyListeners();
    print('notifing listeners');
  }

  void deleteAll() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  void deleteById(int id) async {
    await DBProvider.db.deleteScanById(id);
    getByType(typeSelected);
  }
}
