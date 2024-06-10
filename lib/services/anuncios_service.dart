import 'dart:io';

import 'package:dio/dio.dart';
import 'package:examen_flutter/models/api_response/anuncio_model.dart';
import 'package:examen_flutter/models/api_response/categoria_model.dart';

class AnunciosService {

  AnunciosService(this.dio);

  Dio dio;

  Future<List<CategoriaModel>> consultaCategorias() async {
    final response = await dio.get('productos/categorias');

    if (response.statusCode == HttpStatus.ok) {
      List<CategoriaModel> categorias = (response.data as List<dynamic>)
          .map((data) => CategoriaModel.fromJson(data))
          .toList();
      return categorias;
    } else {
      throw Exception('Error al cargar los anuncios');
    }
  }

  Future<List<AnuncioModel>> consultaAnuncios() async {
    final response =
    await dio.get('productos/anuncios');

    if (response.statusCode == HttpStatus.ok) {
      List<AnuncioModel> anuncios = (response.data as List<dynamic>)
          .map((data) => AnuncioModel.fromJson(data))
          .toList();

      return anuncios;
    } else {
      throw Exception('Error al cargar los anuncios');
    }
  }

  Future<AnuncioModel> consultaAnuncioDetalle(String id) async {
    final response =
    await dio.get('productos/anuncios/$id');

    if (response.statusCode == HttpStatus.ok) {
      return AnuncioModel.fromJson(response.data);
    } else {
      throw Exception('Error al cargar los anuncios');
    }
  }
}