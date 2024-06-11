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
    _contactoCubit.consultaDatosContacto();
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
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage:
                          AssetImage('assets/imagenes/avatar_user.png'),
                    ),
                  ),
                  BlocBuilder<ContactoCubit, ContactoState>(
                    builder: (context, state) {
                      var nombre = '';
                      if (state is ContactoSucces) {
                        nombre = state.contacto.nombre_vendedor;
                      }
                      return Center(
                          child: Text(
                        nombre,
                        style: const TextStyle(),
                      ));
                    },
                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: BlocBuilder<ContactoCubit, ContactoState>(
                          builder: (context, state) {
                            var numero = '';
                            if (state is ContactoSucces) {
                              numero = state.contacto.telefono;
                            }
                            return InkWell(
                              onTap: () {
                                callPhone(
                                    numero.replaceAll(RegExp(r'[^0-9]'), ''));
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      numero,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      ),
                    ),
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

  callPhone(String phone) async {
    Uri phoneno = Uri.parse('tel:$phone');
    if (await canLaunchUrl(phoneno)) {
      await launchUrl(phoneno);
    }
  }
}
