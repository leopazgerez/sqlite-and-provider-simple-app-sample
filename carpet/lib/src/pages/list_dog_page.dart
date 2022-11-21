import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../databases/db.dart';
import '../models/dog_model.dart';
import '../providers/list_dog_model.dart';

class ListDogPage extends StatefulWidget {
  const ListDogPage({Key? key}) : super(key: key);

  @override
  State<ListDogPage> createState() => _ListDogPageState();
}

class _ListDogPageState extends State<ListDogPage> {
  DogsDataBase dataBase = DogsDataBase.instance;
  List<DogModel> dogs = [];
//  Este funcion fue para cuando no utilizaba provider
  _onTap(DogModel dog) {
    setState(() {
      dogs.add(dog);
    });
    setState(() {});
  }

  void onPressed() {
    Navigator.pushReplacementNamed(
      context,'LoadDogPage');
  }

  @override
  Widget build(BuildContext context) {
    dogs = context.read<ListDogModel>().dogs;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Perros"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            onPressed();
          },
        ),
        body: _list());
  }

  Widget _list() {
    return ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, i) => ListTile(
              title: Text('${dogs[i].name}'),
              subtitle: Text('${dogs[i].age}'),
            ));
  }
}
