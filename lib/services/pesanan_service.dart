// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lazywash/models/pesanan_model.dart';

class PesananService {
  CollectionReference _pesananRef =
      FirebaseFirestore.instance.collection('pesanan');

  Future<List<PesananModel>> fetchPesanan() async {
    try {
      QuerySnapshot result = await _pesananRef.get();

      List<PesananModel> pesanan = result.docs.map(
        (e) {
          return PesananModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return pesanan;
    } catch (e) {
      throw e;
    }
  }

  Future<PesananModel> getuserById(String id) async{
    try {
      DocumentSnapshot snapshot = await _pesananRef.doc(id).get();
      return PesananModel(
        id: id, 
        id_pemesan: snapshot['id_pemesan'], 
        nama_pemesan: snapshot['nama_pemesan'],
        nama_penyedia_jasa: snapshot['nama_penyedia_jasa'],
        id_penyedia: snapshot['id_penyedia'], 
        no_telp: snapshot['no_telp'],
        no_telp_penyedia: snapshot['no_telp_penyedia'],
        tgl: snapshot['tgl'],
        jenis_kendaraan: snapshot['jenis_kendaraan'],
        jenis_cuci_kendaraan: snapshot['jenis_cuci_kendaraan'],
        latitude: snapshot['latitude'],
        longitude: snapshot['longitude'],
        harga: snapshot['harga'],
        alamat: snapshot['alamat'],
      );
    } catch (e) {
      throw e;
    }
  }
}
