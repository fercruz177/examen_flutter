import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/api_response/categoria_model.dart';
import '../../../services/anuncios_service.dart';

part 'categorias_state.dart';

class CategoriasCubit extends Cubit<CategoriasState> {
  final AnunciosService _service;

  CategoriasCubit(AnunciosService service)
      : _service = service,
        super(LoadingState());

  consultaCategorias() async{
    emit(LoadingState());
    var categorias = await _service.consultaCategorias();
    emit(SuccessState(categorias));
  }
}
