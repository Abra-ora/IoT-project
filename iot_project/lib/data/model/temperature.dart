class Temperature {
  String value;
  String unit = '°C';

  get temperatureInCelsius => '$value $unit';
  Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      value: json['value'],
    );
  }
}
