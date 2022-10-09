import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/services/pesanan_service.dart';
part 'pesanan_state.dart';

class PesananCubit extends Cubit<PesananState> {
  PesananCubit() : super(PesananInitial());

  void fetchPesanan() async {
    try {
      emit(PesananLoading());

      List<PesananModel> pesanan = await PesananService().fetchPesanan();

      emit(PesananSuccess(pesanan));
    } catch (e) {
      emit(PesananFailed(e.toString()));
    }
  }
}
