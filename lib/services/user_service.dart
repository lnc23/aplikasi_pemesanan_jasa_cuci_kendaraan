
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lazywash/models/user_model.dart';

class UserService {
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'no_telp': user.no_telp,
        'alamat': user.alamat,
        'password': user.password
      });
    } catch (e) {
      throw e;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      
      DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(user.id);

      documentReference.update(
        {
          'email': user.email,
          'name': user.name,
          'no_telp': user.no_telp,
          'alamat': user.alamat
        },
      );
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getuserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        password: snapshot['password'],
        name: snapshot['name'],
        no_telp: snapshot['no_telp'],
        alamat: snapshot['alamat'],
      );
    } catch (e) {
      throw e;
    }
  }
}
