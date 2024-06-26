import 'package:examen_flutter/screens/anuncios/anuncios.dart';
import 'package:examen_flutter/screens/contacto/contacto.dart';
import 'package:examen_flutter/screens/detalle_anuncio/detalle_anuncio.dart';
import 'package:go_router/go_router.dart';

final myRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Anuncios(),
    ),
    GoRoute(
        name: 'detalle',
        path: '/detalle/:id',
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return DetalleAnuncio(id);
        }),
    GoRoute(
        name: 'contacto',
        path: '/contacto/:id',
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return Contacto(id);
        }),
  ],
);
