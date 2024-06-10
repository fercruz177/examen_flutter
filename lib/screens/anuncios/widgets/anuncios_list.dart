import 'package:examen_flutter/screens/anuncios/bloc/anuncios_cubit.dart';
import 'package:examen_flutter/screens/anuncios/bloc/anuncios_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'anuncio_list_item.dart';

class AnunciosList extends StatefulWidget {
  const AnunciosList({super.key});

  @override
  State<AnunciosList> createState() => AnunciosListState();
}

class AnunciosListState extends State<AnunciosList> {
  late AnunciosCubit anunciosCubit;

  @override
  void initState() {
    super.initState();
    anunciosCubit = context.read<AnunciosCubit>();
    anunciosCubit.consultaAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnunciosCubit, AnunciosState>(
      builder: (context, state) {
        if (state is AnunciosLoading) {
          return const CircularProgressIndicator();
        }
        if (state is AnunciosLoaded) {
          return ListView.separated(
            itemCount: state.anuncios.length,
            itemBuilder: (context, index) {
              return AnuncioListItem(state.anuncios[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          );
        } else {
          return const Text('No problem'); //todo
        }
      },
    );
  }
}
