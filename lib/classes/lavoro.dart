class Lavoro {
  final String marca;
  final int imei;
  final String serial;
  final String modello;
  final String note;

  Lavoro({
    required this.serial,
    required this.imei,
    required this.marca,
    required this.modello,
    required this.note,
  });

  factory Lavoro.fromJson(Map<String, dynamic> json) {
    return Lavoro(
      marca: json['marca'] as String,
      serial: json['serial'] as String,
      imei: json['imei'] as int,
      modello: json['modello'] as String,
      note: json['note'] as String,
    );
  }

  //todo
  toJson() {
    return {
      "marca": marca,
      "serial": serial,
      "imei": imei,
      "modello": modello,
      "note": note,
    };
  }
}
