import 'package:equatable/equatable.dart';
import 'package:lazywash/models/admin_model.dart';
import 'package:lazywash/models/user_penyedia_model.dart';
import '../models/user_model.dart';
import '../models/user_penyedia_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthSuccessPenyedia extends AuthState {
  final UserModelPenyedia userpenyedia;

  AuthSuccessPenyedia(this.userpenyedia);

  @override
  // TODO: implement props
  List<Object> get props => [userpenyedia];
}

class AuthSuccessAdmin extends AuthState {
  final UserModelAdmin useradmin;

  AuthSuccessAdmin(this.useradmin);

  @override
  // TODO: implement props
  List<Object> get props => [useradmin];
}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
