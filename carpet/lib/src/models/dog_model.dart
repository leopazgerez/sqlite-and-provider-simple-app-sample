import 'package:flutter/material.dart';

class DogModel{
  int? id;
  String? name;
  int? age;

   DogModel({ this.id, this.age, this.name
  });

   DogModel.fromJson(Map<String, dynamic> result)
        : id = result['id'],
          name = result['name'],
          age = result['age'];
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}