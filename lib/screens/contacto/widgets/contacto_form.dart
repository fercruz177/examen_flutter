import 'package:examen_flutter/screens/contacto/bloc/contacto_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoForm extends StatefulWidget {
  const ContactoForm({super.key});

  @override
  State<ContactoForm> createState() => _ContactoFormState();
}

class _ContactoFormState extends State<ContactoForm> {
  late ContactoCubit _contactoCubit;
  late TextEditingController _nombreController;
  late TextEditingController _correoController;
  late TextEditingController _textMailController;
  final _formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _correoController = TextEditingController();
    _textMailController = TextEditingController();
    _contactoCubit = context.read<ContactoCubit>();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _textMailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactoCubit, ContactoState>(
      listener: (context, state) {
        if (state is MailErrorState) {
          showErrorMesage('Error al enviar el correo');
        } else if (state is MailSuccesState) {
          showSuccesMesage('Correo enviado');
        }
      },
      child: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/imagenes/avatar_user.png'),
                    ),
                  ),
                  const Center(
                      child: Text(
                    'Jhon Smith',
                    style: TextStyle(),
                  )),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Llamar'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        callPhone('1234567890');
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Número',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '+52-5543-6348',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.mail),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Mail'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _nombreController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Nombre', alignLabelWithHint: true),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _correoController,
                    decoration: const InputDecoration(
                      labelText: 'Correo de contacto',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Este campo es requerido';
                      } else if (!regex.hasMatch(value)) {
                        return 'Correo inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _textMailController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      labelText: 'Texto Correo',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _contactoCubit.functionSendMail(_nombreController.text,
                            _correoController.text, _textMailController.text);
                      }
                    },
                    child: const Text('Enviar Correo'),
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<ContactoCubit, ContactoState>(
          builder: (context, state) {
            if (state is MailSendingState) {
              return Container(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container(height: 0);
            }
          },
        ),
      ]),
    );
  }

  showErrorMesage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  showSuccesMesage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(
              Icons.check,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  callPhone(String num) async {
    //todo
    var phoneUri = Uri(scheme: 'tel', path: num);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {}
  }
}
