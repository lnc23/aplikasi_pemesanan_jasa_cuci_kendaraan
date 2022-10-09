part of 'pesanan_cubit.dart';

abstract class PesananState extends Equatable {
  const PesananState();

  @override
  List<Object> get props => [];
}

class PesananInitial extends PesananState {}

class PesananLoading extends PesananState{}

class PesananSuccess extends PesananState{
  
    
  final List<PesananModel> pesanan;

  PesananSuccess(this.pesanan);

  @override
  List<Object> get props => [pesanan];
}

class PesananFailed extends PesananState{
  final String error;

  PesananFailed(this.error);

  @override
  
  List<Object> get props => [error];
}