import 'package:bloc/bloc.dart';
import 'package:examen_flutter/services/contacto_service.dart';
import 'package:flutter/foundation.dart';

part 'contacto_state.dart';

class ContactoCubit extends Cubit<ContactoState> {
  final ContactoService _service;
  ContactoCubit(ContactoService service) :
      _service = service,
        super(LoadinState());

  functionSendMail(String nombre, String correo, String msg) async{
    emit(MailSendingState());
    var enviado = await _service.sendEmail(nombre, correo, msg);
    if(enviado){
      emit(MailSuccesState());
    } else{
      MailErrorState();
    }
  }
}
