class Lighting{
  String value;
  Lighting({required this.value});


  factory Lighting.fromJson(Map<String, dynamic> json) {
    return Lighting(
      value: json['lightStatus'],
    );
  }

}