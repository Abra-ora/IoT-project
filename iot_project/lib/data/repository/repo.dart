import 'package:iot_project/data/dataproviders/api.dart';
import 'package:iot_project/data/model/lighting.dart';
import 'package:iot_project/data/model/temperature.dart';

class Repo {
  final Api api = Api();
  Temperature temperature = Temperature(value: '0');
  Lighting lighting = Lighting(value: '0');

  Future<Temperature> getTemperature() async {
    try {
      temperature.value = await api.fetchTemperature();
      return temperature;
    } catch (e) {
      print(e);
      return Temperature(value: '0');
    }
  }

  Future<Lighting> getLighting() async {
    try {
      lighting.value = await api.fetchLighting();
      return lighting;
    } catch (e) {
      print(e);
      return Lighting(value: '0');
    }
  }

  void postLedAutoControle(bool activated) async {
    try {
      api.activateLedAutoControle(activated);
    } catch (e) {
      throw Exception("Error while activating led auto controle");
    }
  }

  void postAllumedLed(bool activated) async {
    try {
      api.allumeLed(activated);
    } catch (e) {
      throw Exception("Error while alluming led");
    }
  }
}
