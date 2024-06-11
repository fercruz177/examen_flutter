import 'package:bloc/bloc.dart';
import 'package:examen_flutter/models/api_response/contacto_model.dart';
import 'package:examen_flutter/services/contacto_service.dart';
import 'package:flutter/foundation.dart';

part 'contacto_state.dart';

class ContactoCubit extends Cubit<ContactoState> {
  final ContactoService _service;

  ContactoCubit(ContactoService service)
      : _service = service,
        super(LoadinState());

  String idContacto = '';
  ContactoModel? contacto;

  setContactoId(String idContacto) {
    this.idContacto = idContacto;
  }

  consultaDatosContacto() async {
    emit(LoadinState());
    var contacto = await _service.consultaDatosContacto(idContacto);
    this.contacto = contacto;
    emit(ContactoSucces(contacto));
  }

  functionSendMail(String nombre, String correo, String msg) async {
    emit(MailSendingState());
    if (contacto != null) {
      var enviado =
          await _service.sendEmail(contacto!.email, nombre, correo, msg);
      if (enviado) {
        emit(MailSuccesState());
      } else {
        emit(MailErrorState());
      }
    } else {
      emit(MailErrorState());
    }
  }
}
