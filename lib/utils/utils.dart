import 'package:flutter/widgets.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void launchUrlInWebView(BuildContext context, ScanModel scan) async {
  final url = Uri.parse(scan.value);
  print(scan.toJson());
  if (scan.type == 'http' || scan.type == 'https') {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
