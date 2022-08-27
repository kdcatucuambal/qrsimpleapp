import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)?.settings.arguments as ScanModel;
    final CameraPosition initialPosition =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 50);

    //Markers
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: MarkerId(scan.id.toString()),
      position: scan.getLatLng(),
      infoWindow: InfoWindow(
        title: scan.value,
        snippet: scan.type,
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50,
                  ),
                ));
              },
              icon: const Icon(Icons.location_on))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (mapType == MapType.normal) {
            mapType = MapType.hybrid;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
