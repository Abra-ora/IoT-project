part of 'get_sensors_data_bloc.dart';

abstract class GetSensorsDataState {}

class GetSensorsDataInitial extends GetSensorsDataState {
  bool ledAutoControl = false;
}


class LEDAutoControleState extends GetSensorsDataState {
  final bool activated;

  LEDAutoControleState({required this.activated});
}


class LedAllumedState extends GetSensorsDataState {
  final bool activated;

  LedAllumedState({required this.activated});
}

