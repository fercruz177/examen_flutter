import 'package:examen_flutter/screens/contacto/bloc/contacto_cubit.dart';
import 'package:examen_flutter/screens/contacto/widgets/contacto_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';

class Contacto extends StatelessWidget {
  const Contacto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Contacto'),
      ),
      body: BlocProvider(
        create: (context) => sl<ContactoCubit>(),
        child: const ContactoForm(),
      ),
    );
  }
}
