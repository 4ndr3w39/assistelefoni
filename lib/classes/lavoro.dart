class Lavoro {
  final String marca;
  final dynamic acqua;
  final dynamic garanzia;
  final int imei;
  final String id;
  final String serial;
  final String modello;
  final String note;
  final String status;
  final DateTime data;

  Lavoro({
    required this.serial,
    required this.acqua,
    required this.garanzia,
    required this.id,
    required this.status,
    required this.imei,
    required this.marca,
    required this.modello,
    required this.note,
    required this.data,
  });

  factory Lavoro.fromJson(Map<String, dynamic> json) {
    return Lavoro(
      marca: json['marca'] as String,
      status: json['status'] as String,
      id: json['id'] as String,
      acqua: json['acqua'] as dynamic,
      garanzia: json['garanzia'] as dynamic,
      serial: json['serial'] as String,
      imei: json['imei'] as int,
      modello: json['modello'] as String,
      note: json['note'] as String,
      data: json['data'] as DateTime,
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
