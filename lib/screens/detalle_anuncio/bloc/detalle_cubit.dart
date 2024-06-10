import 'package:bloc/bloc.dart';
import 'package:examen_flutter/models/api_response/anuncio_model.dart';
import 'package:meta/meta.dart';

import '../../../services/anuncios_service.dart';

part 'detalle_state.dart';

class DetalleCubit extends Cubit<DetalleState> {
  final AnunciosService _service;

  DetalleCubit(AnunciosService service)
      : _service = service,
        super(LoadingState());

  consultaAnuncios(String id) async {
    emit(LoadingState());
    var anuncio = await _service.consultaAnuncioDetalle(id);
    emit(SuccessState(anuncio));
  }
}
