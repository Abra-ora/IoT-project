part of 'get_sensors_data_bloc.dart';

abstract class GetSensorsDataEvent {}

class ActivateLedAutoControle extends GetSensorsDataEvent{
  final bool activated;

  ActivateLedAutoControle({required this.activated});
}

class PostLedAutoControleValueEvent extends GetSensorsDataEvent{
  final bool activated;

  PostLedAutoControleValueEvent({required this.activated});
}


class PostAllumedLedValueEvent extends GetSensorsDataEvent{
  final bool activated;

  PostAllumedLedValueEvent({required this.activated});
}