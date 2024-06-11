import 'package:examen_flutter/screens/detalle_anuncio/bloc/detalle_cubit.dart';
import 'package:examen_flutter/screens/detalle_anuncio/widgets/image_carousel.dart';
import 'package:examen_flutter/screens/detalle_anuncio/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/service_locator.dart';

class DetalleAnuncio extends StatelessWidget {
  final String id;

  const DetalleAnuncio(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetalleCubit>()..consultaAnuncios(id),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Detalle Anuncio'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 350, child: ImageCarousel(id)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Info(),
                  ],
                )),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<DetalleCubit, DetalleState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: (state is SuccessState)
                          ? () {
                              context.pushNamed('contacto', pathParameters: {
                                'id': state.anuncio.id
                              });
                            }
                          : null,
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        ),
                      ),
                      child: const Text('Contactar Vendedor'),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
