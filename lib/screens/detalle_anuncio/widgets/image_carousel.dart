import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final String productId;
  const ImageCarousel(this.productId,{super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: 'product_img${productId}',child: Image.asset('assets/imagenes/flutter.png',height: 150,));
  }
}
