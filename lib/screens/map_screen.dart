import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    Position myPostion =
        Provider.of<Weather>(context, listen: false).myPosition;
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(myPostion.latitude, myPostion.longitude),
          zoom: 13.0,
          maxZoom: 18,
          minZoom: 5,
          interactiveFlags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/fadihares/cl0xn348l000b14lpwit2vkap/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmFkaWhhcmVzIiwiYSI6ImNsMGdvYnN5NzAweDczZHJwNjBmZ2JjcGEifQ.8rzmDHjL-0NPzrR487QLgQ",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZmFkaWhhcmVzIiwiYSI6ImNsMGdvYnN5NzAweDczZHJwNjBmZ2JjcGEifQ.8rzmDHjL-0NPzrR487QLgQ',
              'id': 'mapbox.satellite',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(myPostion.latitude, myPostion.longitude),
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
