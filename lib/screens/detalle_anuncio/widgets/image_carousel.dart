import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final String productId;

  const ImageCarousel(this.productId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImageCarouselState();
  }
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> imgList = [
    'assets/imagenes/1.png',
    'assets/imagenes/2.png',
    'assets/imagenes/3.png',
    'assets/imagenes/4.png',
    'assets/imagenes/5.png',
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList.map((item) {
      var w = Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: count == 0 ? Hero(
            tag: 'product_img${widget.productId}',
            child: Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          ) : Image.asset(item, fit: BoxFit.cover, width: 1000.0),
        ),
      );
      count++;
      return w;
    }).toList();

    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary)
                      .withOpacity(_current == entry.key ? 0.9 : 0.3)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
