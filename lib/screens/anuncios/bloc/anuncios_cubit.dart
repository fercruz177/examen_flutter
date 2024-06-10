import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/api_response/anuncio_model.dart';
import '../../../services/anuncios_service.dart';
import 'anuncios_state.dart';

class AnunciosCubit extends Cubit<AnunciosState> {
  final AnunciosService _service;
  List<AnuncioModel> _anuncios = List.empty();

  AnunciosCubit(AnunciosService service)
      : _service = service,
        super(LoadingState());

  consultaAnuncios(String? busqueda, int pageKey, int paseSize) async {
    emit(LoadingState());
    _anuncios = await _service.consultaAnuncios();
    var busquedaClear = busqueda??''.trim().toLowerCase();

    if(busquedaClear.isEmpty){
      _anuncios = _anuncios.sublist(pageKey,pageKey+paseSize);
      emit(SuccessState(_anuncios));
    } else{
      var resultadoBusqueda = _anuncios.where((element) {
        return element.titulo.toLowerCase().contains(busquedaClear);
      },).toList();
      emit(SuccessState(resultadoBusqueda));
    }
  }

  buscaAnuncios(String busqueda) async {
    var busquedaClear = busqueda.trim().toLowerCase();
    if(busquedaClear.isEmpty){
      emit(SuccessState(_anuncios));
    } else {

    }
  }
}