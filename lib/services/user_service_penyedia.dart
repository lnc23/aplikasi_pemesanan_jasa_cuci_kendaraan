// ignore_for_file: unused_import, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lazywash/models/user_penyedia_model.dart';

class UserServicePenyedia{
  
  CollectionReference _userReference = 
      FirebaseFirestore.instance.collection('userspenyedia');
  
  Future<UserModelPenyedia> getuserByIdPenyedia(String id) async{
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModelPenyedia(
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

  Future updateUserPenyedia(UserModelPenyedia userpenyedia) async {
    try {
      
      DocumentReference documentReference = FirebaseFirestore.instance.collection("userspenyedia").doc(userpenyedia.id);

      documentReference.update(
        {
          'email': userpenyedia.email,
          'name': userpenyedia.name,
          'no_telp': userpenyedia.no_telp,
          'alamat': userpenyedia.alamat
        },
      );
    } catch (e) {
      throw e;
    }
  }
  Future<void> setUserPenyedia(UserModelPenyedia userpenyedia) async {
    try {
      _userReference.doc(userpenyedia.id).set({
        'email': userpenyedia.email,
        'name': userpenyedia.name,
        'no_telp': userpenyedia.no_telp,
        'alamat': userpenyedia.alamat,
        'password': userpenyedia.password
      });
    } catch (e) {
      throw e;
    }
  }
}