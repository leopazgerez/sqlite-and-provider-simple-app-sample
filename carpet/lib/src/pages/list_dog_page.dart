import 'package:carpet/src/data_access/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dog_model.dart';
import '../providers/list_dog_model.dart';

class ListDogPage extends StatefulWidget {
  const ListDogPage({Key? key}) : super(key: key);

  @override
  State<ListDogPage> createState() => _ListDogPageState();
}

class _ListDogPageState extends State<ListDogPage> {
  DogsDataBase dog = DogsDataBase.instance;
  List<DogModel> dogsList = [];

//  Este funcion fue para cuando no utilizaba provider
//   _onTap(DogModel dog) {
//     setState(() {
//       dogs.add(dog);
//     });
//     setState(() {});
//   }
  @override
  void initState() {    // TODO: implement initState
    super.initState();
    dogListUpdated();
  }
  Future dogListUpdated() async {
    dogsList = await dog.dogsList();
    setState(() {
      dogsList;
    });
  }
  // Future <List<DogModel>> dogList() async {
  //   List<DogModel> listDog = await DogsDataBase.instance.dogsList();
  //   for(int dog = 0 ; dog <= listDog!.length; dog++){
  //     dogs.add(listDog.elementAt(dog));
  //   }
  //   print('Lista de la base de dato : $listDog');
  //   return listDog;
  // }

  void onPressed() {
    Navigator.pushReplacementNamed(
      context,'LoadDogPage');
  }

  @override
  Widget build(BuildContext context) {
    // dogs = context.read<ListDogModel>().dogs;
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
        itemCount: dogsList.length,
        itemBuilder: (context, i) => ListTile(
              title: Text('${dogsList[i].name}'),
              subtitle: Text('${dogsList[i].age}'),
            ));
  }
}
