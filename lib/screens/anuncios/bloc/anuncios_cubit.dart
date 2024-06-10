import 'package:examen_flutter/models/api_response/categoria_model.dart';
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

  consultaAnuncios(List<String> categorias, String? busqueda, int pageKey, int paseSize) async {
    emit(LoadingState());
    _anuncios = await _service.consultaAnuncios();
    if(categorias.isNotEmpty){
      _anuncios = _anuncios.where(
            (element) {
          return categorias.contains(element.tipo);
        },
      ).toList();
      emit(SuccessState(_anuncios));
    } else{
      var busquedaClear = busqueda ?? ''.trim().toLowerCase();

      if (busquedaClear.isEmpty) {
        _anuncios = _anuncios.sublist(pageKey, pageKey + paseSize);
        emit(SuccessState(_anuncios));
      } else {
        var resultadoBusqueda = _anuncios.where(
              (element) {
            return element.titulo.toLowerCase().contains(busquedaClear);
          },
        ).toList();
        emit(SuccessState(resultadoBusqueda));
      }
    }
  }

  filtraAnuncios(String busqueda, int pageKey, int paseSize) async {
    emit(LoadingState());
    _anuncios = await _service.consultaAnuncios();
    var busquedaClear = busqueda ?? ''.trim().toLowerCase();

    if (busquedaClear.isEmpty) {
      _anuncios = _anuncios.sublist(pageKey, pageKey + paseSize);
      emit(SuccessState(_anuncios));
    } else {
      var resultadoBusqueda = _anuncios.where(
        (element) {
          return element.tipo.toLowerCase().contains(busquedaClear);
        },
      ).toList();
      emit(SuccessState(resultadoBusqueda));
    }
  }
}
