part of 'harga_cubit.dart';

abstract class HargaState extends Equatable {
  const HargaState();

  @override
  List<Object> get props => [];
}

class HargaInitial extends HargaState {}

class HargaLoading extends HargaState{}

class HargaSuccess extends HargaState {
  final HargaModel harga;

  HargaSuccess(this.harga);

  @override
  List<Object> get props => [harga];
}

class HargaFailed extends HargaState{
  final String error;

  HargaFailed(this.error);

  @override
  
  List<Object> get props => [error];
}