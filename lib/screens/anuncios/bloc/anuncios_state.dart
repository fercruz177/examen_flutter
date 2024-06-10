import 'package:examen_flutter/models/api_response/categoria_model.dart';

import '../../../models/api_response/anuncio_model.dart';

abstract class AnunciosState{}

class AnunciosLoading extends AnunciosState{}

class AnunciosLoaded extends AnunciosState{
  List<AnuncioModel> anuncios;
  AnunciosLoaded(this.anuncios);
}

