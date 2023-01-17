import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_project/buisness_logique/bloc/get_sensors_data_bloc.dart';
import 'package:iot_project/data/model/lighting.dart';
import 'package:iot_project/data/model/temperature.dart';
import 'package:iot_project/data/repository/repo.dart';
import 'package:iot_project/presentation/widgets/switch_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Temperature temperature = Temperature(value: '0');
  Lighting lighting = Lighting(value: '0');
  Repo repo = Repo();

  bool ledAutoControl = true;
  bool ledOn = false;

  Icon tempIcon = const Icon(
    Icons.sunny,
    size: 100.0,
    color: Colors.yellow,
  );

  getTempIcon() {
    if (double.parse(temperature.value) > 25) {
      tempIcon = const Icon(
        Icons.sunny,
        size: 100.0,
        color: Colors.yellow,
      );
    } else {
      tempIcon = const Icon(
        Icons.ac_unit,
        size: 100.0,
        color: Colors.blue,
      );
    }
  }

  Icon lightIcon = const Icon(
    Icons.lightbulb_outline,
    size: 100.0,
    color: Colors.yellow,
  );

  getlightIcon() {
    if (['Light', 'Bright', 'Very Bright'].contains(lighting.value)) {
      lightIcon = const Icon(
        Icons.lightbulb,
        size: 100.0,
        color: Colors.yellow,
      );
    } else {
      lightIcon = const Icon(
        Icons.dark_mode,
        size: 100.0,
        color: Colors.blue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocConsumer<GetSensorsDataBloc, GetSensorsDataState>(
        listener: (context, state) {
          if (state is LEDAutoControleState) {
            ledAutoControl = state.activated;
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SwitchBtn(
                        title: 'LED Manuall Control',
                        value: ledAutoControl,
                        isForLedControle: true),
                    const Divider(),
                    Visibility(
                      visible: ledAutoControl,
                      child: SwitchBtn(
                          title: 'LED On',
                          value: ledOn,
                          isForLedControle: false),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                FutureBuilder<Temperature>(
                    future: repo.getTemperature(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        temperature = snapshot.data as Temperature;
                        getTempIcon();
                        return Card(
                          color: Colors.grey[100],
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                tempIcon,
                                const SizedBox(height: 20.0, width: 200),
                                Text(
                                  temperature.temperatureInCelsius,
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                FutureBuilder<Lighting>(
                    future: repo.getLighting(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        lighting = snapshot.data as Lighting;
                        getlightIcon();
                        return Card(
                          color: Colors.grey[100],
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                lightIcon,
                                const SizedBox(height: 20.0, width: 200),
                                Text(
                                  lighting.value,
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: const Color.fromARGB(255, 0, 85, 155),
        onPressed: () {
          Timer.periodic(
            const Duration(seconds: 1),
            (timer) => setState(() {}),
          );
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
