part of 'contacto_cubit.dart';

@immutable
sealed class ContactoState {}

final class LoadinState extends ContactoState {}

final class MailSendingState extends ContactoState {}

final class MailSuccesState extends ContactoState {}

final class MailErrorState extends ContactoState {}
