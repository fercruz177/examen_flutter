import 'package:examen_flutter/screens/anuncios/bloc/anuncios_cubit.dart';
import 'package:examen_flutter/screens/anuncios/bloc/categorias_cubit.dart';
import 'package:examen_flutter/screens/anuncios/widgets/anuncios_categorias_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import 'widgets/anuncios_list.dart';

class Anuncios extends StatefulWidget {
  const Anuncios({super.key});

  @override
  State<Anuncios> createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Buscador anuncio'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AnunciosCubit>()),
            BlocProvider(create: (context) => sl<CategoriasCubit>())
          ],
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
               /* SizedBox(
                  height: 50,
                  child: AnunciosCategoriasFilter(),
                ),*/
                SizedBox(
                  height: 10,
                ),
                Expanded(child: AnunciosList())
              ],
            ),
          ),
        ));
  }
}
