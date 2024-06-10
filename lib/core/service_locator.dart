import 'package:dio/dio.dart';
import 'package:examen_flutter/screens/anuncios/bloc/anuncios_cubit.dart';
import 'package:examen_flutter/screens/contacto/bloc/contacto_cubit.dart';
import 'package:examen_flutter/screens/detalle_anuncio/bloc/detalle_cubit.dart';
import 'package:examen_flutter/services/anuncios_service.dart';
import 'package:examen_flutter/services/contacto_service.dart';
import 'package:get_it/get_it.dart';

import '../screens/anuncios/bloc/categorias_cubit.dart';

final GetIt sl = GetIt.instance;

void init() {
  _initCore();
}

void _initCore() {
  sl.registerLazySingleton<Dio>(() {
    BaseOptions baseOption = BaseOptions(
      baseUrl: 'https://6665e606d122c2868e422119.mockapi.io/'
    );
    return Dio(baseOption);
  });
  sl.registerFactory<AnunciosService>(() => AnunciosService(sl()));
  sl.registerFactory<AnunciosCubit>(() => AnunciosCubit(sl()));
  sl.registerFactory<CategoriasCubit>(() => CategoriasCubit(sl()));
  sl.registerFactory<DetalleCubit>(() => DetalleCubit(sl()));
  sl.registerFactory<ContactoService>(() => ContactoService());
  sl.registerFactory<ContactoCubit>(() => ContactoCubit(sl()));

}
