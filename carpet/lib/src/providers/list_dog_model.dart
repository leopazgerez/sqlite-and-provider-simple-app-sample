import 'package:flutter/material.dart';

import '../models/dog_model.dart';


class ListDogModel  with ChangeNotifier {
  int? id;
  final List<DogModel> _dogs= [];

  List<DogModel> get dogs {
    return _dogs;
  }

  void addDogToList(DogModel dog) {
    _dogs.add(dog);
    notifyListeners();
  }
}