part of 'detalle_cubit.dart';

@immutable
sealed class DetalleState {}

final class LoadingState extends DetalleState {}

final class SuccessState extends DetalleState{
  final AnuncioModel anuncio;
  SuccessState(this.anuncio);
}

final class ErrorState extends DetalleState{}
