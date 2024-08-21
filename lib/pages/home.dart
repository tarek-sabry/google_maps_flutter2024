import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const LatLng _pGooglePlex = LatLng(30.366997625573735, 31.381620124759138);

  //static const LatLng _pGooglePlex =LatLng(37.43296265331129, -122.08832357078792);
  static const LatLng _pApplePark = LatLng(30.3515, 31.3072);

  var myMarkers = HashSet<Marker>();
  BitmapDescriptor? customMarker;
  List<Polyline> myPolyLine = []; // array

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  addPolyLine() {
    PolylineId id = const PolylineId("1");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        width: 3,
        points: polylineCoordinates
    );
    polylines[id] = polyline;
    setState((){});
  }

  void makeLines() async {
    await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyC_TAnZd38BygEQZrWEaTEy5WHD4fOsaRY',
        request: PolylineRequest(
          origin: PointLatLng(30.36719900725875, 31.381893679688584),
          destination: PointLatLng(30.311962574142964, 31.323223279466188),
          mode: TravelMode.walking,
          //wayPoints: [PolylineWayPoint(location: "cairo , Egypt")],

        ),

    ).then((value) {
      value.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));

      });
    }).then((value) {
      addPolyLine();
    });
  }

  //To Make Marker
  getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/gradient-landscape.jpg',
    );
    const Size.fromHeight(15);
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
    createPolyline();
    makeLines();
  }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }
  //
  // Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
  //   final Uint8List imageData = await getBytesFromAsset(path, width);
  //   return BitmapDescriptor.fromBytes(imageData);
  // }
  // String _iconImage = 'assets/images/' + path['q'].toString() + '.png';
  // static final X = getBitmapDescriptorFromAssetBytes("asset/image.png", 35);
  //

  Set<Polygon> myPolygon() {
    // To Make Polygon
    var polygonCoords = <LatLng>[];
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    //30.364003013838335, 31.383477526084597
    var polygonSet = <Polygon>{};
    polygonSet.add(
      Polygon(
        strokeWidth: 2,
        polygonId: const PolygonId('1'),
        points: polygonCoords,
        strokeColor: Colors.red,
      ),
    );

    return polygonSet;
  }

  // To Make Circles
  Set<Circle> myCircles = Set.from([
    const Circle(
      circleId: CircleId('1'),
      center: LatLng(30.366997625573735, 31.381620124759138),
      radius: 4000,
      strokeWidth: 2,
      fillColor: Colors.deepOrange,
    )
  ]);

  createPolyline() {     // make Lines
    myPolyLine.add(
        Polyline(
        polylineId:  const PolylineId('1'),
        color: Colors.blue,
        width: 3,
        points: const [
           LatLng(30.36719900725875, 31.381893679688584),
           LatLng(30.35359929384697, 31.38960001763985),
        ],
         patterns: [   // تستخدم لعمل خطوط متقطعة
           PatternItem.dash(20),
           PatternItem.gap(10),
         ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Google Map'),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: _pGooglePlex,
                zoom: 10,
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                setState(() {
                  myMarkers.add(
                    Marker(
                      markerId: const MarkerId('1'),
                      position: _pGooglePlex,
                      infoWindow: const InfoWindow(
                        title: 'Ali TArek Factory',
                        snippet: 'Word Finder helps you win word games',
                      ),
                      onTap: () {},
                      // icon: customMarker!,
                    ),
                  );
                });
              },
              /*
              markers: myMarkers,
              polygons: myPolygon(),
              circles: myCircles,
               */
             // polylines: myPolyLine.toSet(),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            // Container(
            //   width: 50,
            //   height: 120,
            //   alignment: Alignment.topCenter,
            //   child: Image.asset(
            //     'assets/images/gradient-landscape.jpg',
            //     fit: BoxFit.fill,
            //   ),
            // ),

            Container(
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Tarek App',
                style: TextStyle(fontSize: 50, color: Colors.deepOrange),
              ),
            ),
          ],
        ));
  }
}
