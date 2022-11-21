import 'package:carpet/src/pages/list_dog_page.dart';
import 'package:carpet/src/pages/load_dog_page.dart';
import 'package:carpet/src/providers/list_dog_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => DogModel(),
        // ),
        ChangeNotifierProvider(
          create: (context) => ListDogModel(),
        )
      ],
      child: MaterialApp(
          initialRoute: 'ListOfDog',
          routes: {
            'ListOfDog': (context) => ListDogPage(),
            'LoadDogPage' : (context)  => LoadDogPage(),
          }),
    );
  }
}
