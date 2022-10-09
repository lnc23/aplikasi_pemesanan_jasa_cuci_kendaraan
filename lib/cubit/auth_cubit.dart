import 'package:bloc/bloc.dart';
import 'package:lazywash/cubit/auth_state.dart';
import 'package:lazywash/models/admin_model.dart';
import 'package:lazywash/models/user_model.dart';
import 'package:lazywash/models/user_penyedia_model.dart';
import 'package:lazywash/services/admin_service.dart';
import 'package:lazywash/services/auth_service.dart';
import 'package:lazywash/services/auth_service_admin.dart';
import 'package:lazywash/services/auth_service_penyedia.dart';
import 'package:lazywash/services/user_service.dart';
import 'package:lazywash/services/user_service_penyedia.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp({
    required String email,
    required String password,
    required String name,
    required String no_telp,
    required String alamat,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signUp(
          email: email,
          password: password,
          name: name,
          no_telp: no_telp,
          alamat: alamat);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUpPenyedia({
    required String email,
    required String password,
    required String name,
    required String no_telp,
    required String alamat,
  }) async {
    try {
      emit(AuthLoading());

      UserModelPenyedia user = await AuthServicePenyedia().signUpPenyedia(
          email: email,
          password: password,
          name: name,
          no_telp: no_telp,
          alamat: alamat);

      emit(AuthSuccessPenyedia(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateData({
    required String email,
    required String password,
    required String name,
    required String no_telp,
    required String alamat,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().updateData(
        email: email,
        password: password,
        nama: name,
        no_telp: no_telp,
        alamat: alamat,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateDataPenyedia({
    required String email,
    required String password,
    required String name,
    required String no_telp,
    required String alamat,
  }) async {
    try {
      emit(AuthLoading());

      UserModelPenyedia userpenyedia =
          await AuthServicePenyedia().updateDataPenyedia(
        email: email,
        password: password,
        nama: name,
        no_telp: no_telp,
        alamat: alamat,
      );

      emit(AuthSuccessPenyedia(userpenyedia));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signInPenyedia({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModelPenyedia userpenyedia =
          await AuthServicePenyedia().SignInPenyedia(
        email: email,
        password: password,
      );
      emit(AuthSuccessPenyedia(userpenyedia));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signInAdmin({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModelAdmin useradmin = await AuthServiceAdmin().signInAdmin(
        email: email,
        password: password,
      );
      emit(AuthSuccessAdmin(useradmin));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOutPenyedia() async {
    try {
      emit(AuthLoading());
      await AuthServicePenyedia().signOutPenyedia();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOutAdmin() async {
    try {
      emit(AuthLoading());
      await AuthServiceAdmin().signOutadmin();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getuserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUserPenyedia(String id) async {
    try {
      UserModelPenyedia userpenyedia =
          await UserServicePenyedia().getuserByIdPenyedia(id);
      emit(AuthSuccessPenyedia(userpenyedia));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUserAdmin(String id) async {
    try {
      UserModelAdmin useradmin = await UserServiceAdmin().getuserByIdAdmin(id);
      emit(AuthSuccessAdmin(useradmin));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
