// ignore_for_file: unused_import, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lazywash/models/admin_model.dart';
import 'package:lazywash/models/user_penyedia_model.dart';

class UserServiceAdmin{
  
  CollectionReference _userReference = 
      FirebaseFirestore.instance.collection('admin');
  
  Future<UserModelAdmin> getuserByIdAdmin(String id) async{
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModelAdmin(
        id: id, 
        email: snapshot['email'], 
        name: snapshot['name'], 
        password: snapshot['password'],
        no_telp: snapshot['no_telp'],
        alamat: snapshot['alamat']
      );
    } catch (e) {
      throw e;
    }
  }

  Future updateUserAdmin(UserModelAdmin useradmin) async {
    try {
      
      DocumentReference documentReference = FirebaseFirestore.instance.collection("admin").doc(useradmin.id);

      documentReference.update(
        {
          'email': useradmin.email,
          'name': useradmin.name,
          'no_telp': useradmin.no_telp,
          'alamat': useradmin.alamat
        },
      );
    } catch (e) {
      throw e;
    }
  }
}