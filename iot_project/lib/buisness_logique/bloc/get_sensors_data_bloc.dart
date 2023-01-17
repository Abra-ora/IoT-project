import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:iot_project/data/repository/repo.dart';
part 'get_sensors_data_event.dart';
part 'get_sensors_data_state.dart';

class GetSensorsDataBloc
    extends Bloc<GetSensorsDataEvent, GetSensorsDataState> {
  final Repo repo = Repo();
  GetSensorsDataBloc() : super(GetSensorsDataInitial()) {
    on<GetSensorsDataEvent>((event, emit) async {
      if (event is ActivateLedAutoControle) {
        emit(LEDAutoControleState(activated: event.activated));
      }
    });

    on<PostLedAutoControleValueEvent>((event, emit) async {
      repo.postLedAutoControle(event.activated);
      emit(LEDAutoControleState(activated: event.activated));
    });

    on<PostAllumedLedValueEvent>((event, emit) async {
      log("==================================");
      repo.postAllumedLed(event.activated);
      emit(LedAllumedState(activated: event.activated));
    });
  }
}
