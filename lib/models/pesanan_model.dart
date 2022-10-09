
import 'package:equatable/equatable.dart';

class PesananModel extends Equatable {
  final String? id;
  final String? id_pemesan;
  final String? nama_pemesan;
  final String? nama_penyedia_jasa;
  final String? id_penyedia;
  final int? no_telp;
  final int? no_telp_penyedia;
  final String? tgl;
  final String? jenis_kendaraan;
  final String? jenis_cuci_kendaraan;
  final String? alamat;
  final double? latitude;
  final double? longitude;
  final String? harga;
  final String? status;

  PesananModel({
    required this.id,
    this.id_pemesan = '',
    this.nama_pemesan = '',
    this.nama_penyedia_jasa= '',
    this.id_penyedia = '',
    this.no_telp,
    this.no_telp_penyedia,
    this.tgl = '',
    this.jenis_kendaraan = '',
    this.jenis_cuci_kendaraan = '',
    this.alamat = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.harga = '',
    this.status = '',
  });

  factory PesananModel.fromJson(String id, Map<String, dynamic> json) =>
      PesananModel(
        id: id,
        id_pemesan: json['id_pemesan'],
        nama_pemesan: json['nama_pemesan'],
        nama_penyedia_jasa: json['nama_penyedia_jasa'],
        id_penyedia: json['id_penyedia'],
        no_telp: json['no_telp'],
        no_telp_penyedia: json['no_telp_penyedia'],
        tgl: json['tgl'],
        jenis_kendaraan: json['jenis_kendaraan'],
        jenis_cuci_kendaraan: json['jenis_cuci_kendaraan'],
        alamat: json['alamat'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        harga: json['harga'],
        status: json['status'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        id_pemesan,
        nama_pemesan,
        nama_penyedia_jasa,
        id_penyedia,
        no_telp,
        tgl,
        jenis_kendaraan,
        jenis_cuci_kendaraan,
        alamat,
        latitude,
        longitude,
        harga,
        status,
      ];
}
