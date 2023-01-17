import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class Api {
  final url = 'http://10.0.2.2:8000';

  Future<String> fetchTemperature() async {
    var result = await http.get(Uri.parse('$url/temperature'));
    double temp = jsonDecode(result.body)['temperature']['temperature'];
    return temp.toStringAsFixed(2);
  }

  Future<String> fetchLighting() async {
    var result = await http.get(Uri.parse('$url/light'));
    return jsonDecode(result.body)['light']['lightStatus'];
  }

  Future<int> activateLedAutoControle(bool activated) async {
    var response = await http.post(Uri.parse('$url/led/autocontrole'),
        body: jsonEncode({'ledAutoControle': activated.toString()}),
        headers: {'Content-Type': 'application/json'});
    log("response: ${response.statusCode}");
    return response.statusCode;
  }

  void allumeLed(bool allumeLed) async {
    await http.post(Uri.parse('$url/led/manuallcontrole'),
        body: jsonEncode({'LedManuallControle': allumeLed.toString()}),
        headers: {'Content-Type': 'application/json'});
  }
}
