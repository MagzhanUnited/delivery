import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LugLocationView2 extends StatefulWidget {
  LugLocationView2({
    Key? key,
  }) : super(key: key);

  @override
  _LugLocationView2State createState() => _LugLocationView2State();
}

class _LugLocationView2State extends State<LugLocationView2> {
  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Маршрут'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            // myLocationButtonEnabled: false,
            // zoomControlsEnabled: false,

            padding: EdgeInsets.only(top: 135),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,

            initialCameraPosition: CameraPosition(
              target: LatLng(51.128253, 71.430545),
              zoom: 15,
            ),
            onMapCreated: (controller) => _googleMapController = controller,
            // markers: {
            //   if (_origin != null) _origin,
            //   if (_destination != null) _destination
            // },
            // polylines: {
            //   if (_info != null)
            //     Polyline(
            //       polylineId: const PolylineId('overview_polyline'),
            //       color: Colors.red,
            //       width: 5,
            //       points: _info.polylinePoints
            //           .map((e) => LatLng(e.latitude, e.longitude))
            //           .toList(),
            //     ),
            // },
            onLongPress: _addMarker,
          ),
          // if (_info != null)
          //   Positioned(
          //     top: 20.0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 6.0,
          //         horizontal: 12.0,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.yellowAccent,
          //         borderRadius: BorderRadius.circular(20.0),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black26,
          //             offset: Offset(0, 2),
          //             blurRadius: 6.0,
          //           )
          //         ],
          //       ),
          //       child: Text(
          //         '${_info.totalDistance}, ${_info.totalDuration}',
          //         style: const TextStyle(
          //           fontSize: 18.0,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
    }
  }
}
