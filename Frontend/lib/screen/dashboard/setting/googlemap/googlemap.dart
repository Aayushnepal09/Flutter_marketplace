import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglemapScreen extends StatefulWidget {
  const GooglemapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GooglemapScreenState createState() => _GooglemapScreenState();
}

class _GooglemapScreenState extends State<GooglemapScreen> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = {}; //markers for google map
  LatLng showLocation =
      const LatLng(27.7089427, 85.3086205); //location to show in map

  @override
  void initState() {
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'KinBech ',
        snippet: 'This is the offical address',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("KinBech Headoffice"),
          backgroundColor: Colors.green,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/setting");
            },
          )),
      body: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 20.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.hybrid, //map type
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
