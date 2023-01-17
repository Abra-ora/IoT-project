import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_project/presentation/pages/home.dart';

import 'buisness_logique/bloc/get_sensors_data_bloc.dart';

void main() {
  // runApp(const MyApp());
  runApp(BlocProvider(
    create: ((context) => GetSensorsDataBloc()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
