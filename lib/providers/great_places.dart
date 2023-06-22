import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // retrieves a copy of the items do that we
  // can get access to the copy of the items from anywhere on the app
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: null,
        longitude: null,
        address: null,
      ),
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final placeList = await DBHelper.getData('user_places');
    _items = placeList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: null,
              longitude: null,
              address: null,
            ),
            image: File(item['image']),
          ),
        )
        .toList();
    //to inform interested places about the set of newly loaded data
    notifyListeners();
  }
}
