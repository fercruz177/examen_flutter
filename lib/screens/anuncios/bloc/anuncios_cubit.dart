import 'dart:async';

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
        super(AnunciosLoading());

  consultaAnuncios() async {
    emit(AnunciosLoading());
    _anuncios = await _service.consultaAnuncios();
    emit(AnunciosLoaded(_anuncios));
  }

  buscaAnuncios(String busqueda) async {
    var busquedaClear = busqueda.trim().toLowerCase();
    if(busquedaClear.isEmpty){
      emit(AnunciosLoaded(_anuncios));
    } else {
      var resultadoBusqueda = _anuncios.where((element) {
        return element.titulo.toLowerCase().contains(busquedaClear);
      },).toList();
      emit(AnunciosLoaded(resultadoBusqueda));
    }
  }
}