import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  // retrieves a copy of the items do that we 
  // can get access to the copy of the items from anywhere on the app
  List<Place> get items {
    return [..._items];
  }
}
