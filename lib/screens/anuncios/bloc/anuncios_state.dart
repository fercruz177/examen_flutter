import 'package:flutter/foundation.dart';

import '../../../models/api_response/anuncio_model.dart';

@immutable
sealed class AnunciosState{}

final class LoadingState extends AnunciosState{}

final class SuccessState extends AnunciosState{
  final List<AnuncioModel> anuncios;
  SuccessState(this.anuncios);
}

