import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ContactoService{
  Future<bool> sendEmail(String nombre, String correo, String msg) async {
    String username = 'ejemploe304@gmail.com';
    String password =
        'vvbsnxczrcmgnhlm';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    final message = Message()
      ..from = Address(correo, nombre)
      ..recipients.add('fer.cruz.117@gmail.com')
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
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}