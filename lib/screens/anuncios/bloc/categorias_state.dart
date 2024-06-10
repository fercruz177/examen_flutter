part of 'categorias_cubit.dart';

sealed class CategoriasState {}

final class LoadingState extends CategoriasState {}

final class SuccessState extends CategoriasState{
  List<CategoriaModel> categorias;
  SuccessState(this.categorias);
}

final class ErrorState extends CategoriasState{}
