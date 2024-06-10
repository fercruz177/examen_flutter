import 'package:examen_flutter/core/extensions.dart';
import 'package:examen_flutter/models/api_response/anuncio_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnuncioListItem extends StatelessWidget {
  final AnuncioModel anuncio;

  const AnuncioListItem(this.anuncio, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          context.pushNamed('detalle', pathParameters: {'id': anuncio.id});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Hero(
                    tag: 'product_img${anuncio.id}',
                    child: Image.network(
                      anuncio.imagen,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(anuncio.titulo)),
                        Text('\$${anuncio.precio.toCurrencyFormat()}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(anuncio.descripcion, maxLines: 3, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
