import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_access/db.dart';
import '../models/dog_model.dart';
import '../providers/list_dog_model.dart';

class LoadDogPage extends StatefulWidget {
  final Function(DogModel)? onTap;
  LoadDogPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<LoadDogPage> createState() => _LoadDogPageState();
}

class _LoadDogPageState extends State<LoadDogPage> {
  // DogsDataBase dataBase = DogsDataBase.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? nameValidator(name) {
    if (name == null || name.isEmpty) {
      return 'Nombre requerido';
    }
    return null;
  }

  String? ageValidator(age) {
    if (age == null || age.isEmpty) {
      return 'Edad requerido';
    }
    return null;
  }

  void clear() {
    nameController.clear();
    ageController.clear();
  }

  void onSave(ListDogModel dogs) {
    if (formKey.currentState!.validate()) {
      DogModel dog = DogModel();
      dog.name = nameController.text;
      dog.age = int.parse(ageController.text);
      DogsDataBase.instance.insertDog(dog);
      dogs.addDogToList(dog);
      Navigator.pushReplacementNamed(context, 'ListOfDog');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Guardado')));
      print('Messirve');
    } else {
      print('No Messirve');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carga de perros'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _form(),
          const SizedBox(
            height: 20,
          ),
          _button(),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: nameValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                ),
                validator: ageValidator,
              ),
            ],
          ),
        ));
  }

  Widget _button() {
    return Consumer<ListDogModel>(
      builder: (context, dogs, _) => ElevatedButton(
          onPressed: () {
            onSave(dogs);
            // if (formKey.currentState!.validate()) {
            //   DogModel dog = DogModel();
            //   dog.name = nameController.text;
            //   dog.age = int.parse(ageController.text);
            //   widget.onTap(dog);
            //   dogs.addDogToList(dog);
            //   clear();
            //   onSave();
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(const SnackBar(content: Text('Guardado')));
            // } else {
            //   print('No  Messirve');
            // }
          },
          child: const Text('Guardar')),
    );
  }
}
