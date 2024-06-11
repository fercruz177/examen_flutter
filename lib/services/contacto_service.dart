import 'dart:io';

import 'package:dio/dio.dart';
import 'package:examen_flutter/models/api_response/contacto_model.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ContactoService {
  final Dio dio;

  ContactoService(this.dio);

  Future<ContactoModel> consultaDatosContacto(String id) async {
    final response = await dio.get('productos/anuncios/$id');

    if (response.statusCode == HttpStatus.ok) {
      return ContactoModel.fromJson(response.data);
    } else {
      throw Exception('Error al cargar datos de contacto');
    }
  }

  Future<bool> sendEmail(
      String recipient, String nombre, String correo, String msg) async {
    String username = 'ejemploe304@gmail.com';
    String password = 'vvbsnxczrcmgnhlm';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(correo, nombre)
      ..recipients.add(recipient)
      // ..ccRecipients.addAll(['a@gmail.com', 'b@gmail.com'])
      ..subject = 'Productos Diversos'
      ..text = msg;
    // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
    // ..attachments = [
    //   FileAttachment(File('image.png'))  //For Adding Attachments
    //     ..location = Location.inline
    //     ..cid = '<myimg@3.141>'
    // ]

    try {
      final sendReport = await send(message, smtpServer);
      return true;
    } on MailerException catch (e) {
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
