class HargaModel {
  final String? id;
  final int? cuci_motor_biasa;
  final int? cuci_motor_lengkap;
  final int? cuci_mobil_biasa;
  final int? cuci_mobil_lengkap;
  final int? jarak_500m;
  final int? jarak_1000m;
  final int? jarak_1500m;
  final int? jarak_2000m;

  HargaModel({
    required this.id,
    this.cuci_motor_biasa = 0,
    this.cuci_motor_lengkap = 0,
    this.cuci_mobil_biasa = 0,
    this.cuci_mobil_lengkap = 0,
    this.jarak_500m = 0,
    this.jarak_1000m = 0,
    this.jarak_1500m = 0,
    this.jarak_2000m = 0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'cuci_motor_biasa': cuci_motor_biasa,
        'cuci_motor_lengkap': cuci_motor_lengkap,
        'cuci_mobil_biasa': cuci_mobil_biasa,
        'cuci_mobil_lengkap': cuci_mobil_lengkap,
        'jarak_500m': jarak_500m,
        'jarak_1000m': jarak_1000m,
        'jarak_1500m': jarak_1500m,
        'jarak_2000m': jarak_2000m,
      };

  static HargaModel fromJson(Map<String, dynamic> json) => HargaModel(
        id: json['id'],
        cuci_motor_biasa: json['cuci_motor_biasa'],
        cuci_motor_lengkap: json['cuci_motor_lengkap'],
        cuci_mobil_biasa: json['cuci_mobil_biasa'],
        cuci_mobil_lengkap: json['cuci_mobil_lengkap'],
        jarak_500m: json['jarak_500m'],
        jarak_1000m: json['jarak_1000m'],
        jarak_1500m: json['jarak_1500m'],
        jarak_2000m: json['jarak_2000m'],
      );
}
