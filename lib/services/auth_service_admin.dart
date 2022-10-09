import 'package:firebase_auth/firebase_auth.dart';
import 'package:lazywash/models/admin_model.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/models/user_penyedia_model.dart';
import 'package:lazywash/services/admin_service.dart';
import 'package:lazywash/services/user_service_penyedia.dart';

class AuthServiceAdmin{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModelAdmin> signInAdmin({
    required String email, 
    required String password
  }) async{
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      UserModelAdmin useradmin = await UserServiceAdmin().getuserByIdAdmin(userCredential.user!.uid);
      return useradmin;
    } catch (e) { 
      throw e;
    }
  }

  Future<void> signOutadmin() async{
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  Future<UserModelAdmin> updateDataadmin({
    required String email,
    required String password,
    required String nama,
    required String alamat,
    required String no_telp,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModelAdmin useradmin = UserModelAdmin(
        id: userCredential.user!.uid,
        email: email,
        password: password,
        name: nama,
        no_telp: no_telp,
        alamat: alamat,
      );

      await UserServiceAdmin().updateUserAdmin(useradmin);
      return useradmin;
    } catch (e) {
      throw e;
    }
  }
}