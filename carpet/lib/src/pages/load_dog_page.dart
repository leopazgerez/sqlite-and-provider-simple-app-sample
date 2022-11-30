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

  Future  validationOnScope(BuildContext context) async {
      final dialog = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            content: Text('¿Seguro que desea salir?'),
            actions: [
              IconButton(onPressed: () => Navigator.of(context).pop(false), icon: Icon(Icons.cancel)),
              IconButton(onPressed: () => Navigator.of(context).pop(true), icon: Icon(Icons.check_circle)),
            ],
          ),
      );
      if(dialog){
        Navigator.pushReplacementNamed(context, 'ListOfDog');;
      }
}

  Future onSave(ListDogModel dogs) async {
    if (formKey.currentState!.validate()) {
      await DogsDataBase.instance.insertDog(
          DogModel(
              name: nameController.text,
              age: int.parse(ageController.text)
          ));
      // dogs.addDogToList();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'ListOfDog');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Guardado')));
      print('Messirve');
    } else {
      print('No Messirve');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        validationOnScope(context);
          return Future.value(false);
      },
      child: Scaffold(
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
