import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazywash/models/harga_model.dart';
import '../services/harga_service.dart';
part 'harga_state.dart';

class HargaCubit extends Cubit<HargaState> {
  HargaCubit() : super(HargaInitial());

  void getHarga() async {
    try {
      HargaModel harga =
          await HargaService().gethargaById("harga_cuci_kendaraan");
      emit(HargaSuccess(harga));
    } catch (e) {
      emit(HargaFailed(e.toString()));
    }
  }
}
