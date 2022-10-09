import 'package:firebase_auth/firebase_auth.dart';
import 'package:lazywash/models/admin_model.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/models/user_penyedia_model.dart';
import 'package:lazywash/services/user_service_penyedia.dart';

class AuthServicePenyedia{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModelPenyedia> SignInPenyedia({
    required String email, 
    required String password
  }) async{
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      UserModelPenyedia userpenyedia = await UserServicePenyedia().getuserByIdPenyedia(userCredential.user!.uid);
      return userpenyedia;
    } catch (e) { 
      throw e;
    }
  }

  Future<void> signOutPenyedia() async{
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  Future<UserModelPenyedia> updateDataPenyedia({
    required String email,
    required String password,
    required String nama,
    required String alamat,
    required String no_telp,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModelPenyedia userpenyedia = UserModelPenyedia(
        id: userCredential.user!.uid,
        email: email,
        password: password,
        name: nama,
        no_telp: no_telp,
        alamat: alamat,
      );

      await UserServicePenyedia().updateUserPenyedia(userpenyedia);
      return userpenyedia;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModelPenyedia> signUpPenyedia({
    required String email,
    required String password,
    required String name,
    required String no_telp,
    required String alamat,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModelPenyedia userpenyedia = UserModelPenyedia(
        id: userCredential.user!.uid,
        email: email,
        password: password,
        name: name,
        no_telp: no_telp,
        alamat: alamat,
      );

      await UserServicePenyedia().setUserPenyedia(userpenyedia);

      return userpenyedia;
    } catch (e) {
      throw e;
    }
  }
}