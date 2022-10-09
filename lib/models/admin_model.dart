
import 'package:equatable/equatable.dart';

class UserModelAdmin extends Equatable{

  final String id;
  final String email;
  final String name;
  final String password;
  final String no_telp;
  final String alamat;

  UserModelAdmin({
    required this.id, 
    required this.email, 
    required this.name, 
    required this.password,
    required this.no_telp,
    required this.alamat, 
    });


  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, no_telp, alamat, password];

}