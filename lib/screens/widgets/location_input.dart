import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelectPlace,
  });

  final Function onSelectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    // final locData = await Location().getLocation();
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // checking if location service is on
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // ask for permissions for app to access location functionality
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    _showPreview(
      locationData.latitude!,
      locationData.longitude!,
    );
    // print(
    //     'latitude: ${locationData.latitude}\n longitude: ${locationData.longitude}');

    widget.onSelectPlace(locationData.latitude!, locationData.longitude!);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).pushNamed(MapScreen.routeName) as LatLng;
    //     await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const MapScreen(
    //       isSelecting: true,
    //     ),
    //   ),
    // );

    // if (selectedLocation == null) {
    //   return;
    // }

    // showing a preview of the map on the location chosen and displaying it.
    _showPreview(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);

    // print(
    //     'latitude: ${selectedLocation.latitude}\n longitude: ${selectedLocation.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select Location'),
            ),
          ],
        ),
      ],
    );
  }
}
