import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lazywash/models/harga_model.dart';

class HargaService {
  CollectionReference _hargaRef =
      FirebaseFirestore.instance.collection('harga');

  Future<HargaModel> gethargaById(String id) async {
    try {
      DocumentSnapshot snapshot = await _hargaRef.doc(id).get();
      return HargaModel(
        id: id,
        cuci_motor_biasa: snapshot['cuci_motor_biasa'],
        cuci_motor_lengkap: snapshot['cuci_motor_lengkap'],
        cuci_mobil_biasa: snapshot['cuci_mobil_biasa'],
        cuci_mobil_lengkap: snapshot['cuci_mobil_lengkap'],
        jarak_500m: snapshot['jarak_500m'],
        jarak_1000m: snapshot['jarak_1000m'],
        jarak_1500m: snapshot['jarak_1500m'],
        jarak_2000m: snapshot['jarak_2000m'],
      );
    } catch (e) {
      throw e;
    }
  }
}
