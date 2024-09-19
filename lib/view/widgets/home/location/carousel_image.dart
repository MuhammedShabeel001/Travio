import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../widgets/global/custom_image_loader.dart';

class CarouselImage extends StatelessWidget {
  final List<String> images;
  final Function(int) onPageChanged;
  final int currentIndex;

  const CarouselImage({
    Key? key,
    required this.images,
    required this.onPageChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 350,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 350.0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
            items: images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) => ShimmerPlaceholder(
                        width: MediaQuery.of(context).size.width,
                        height: 350.0,
                      ),
                      errorWidget: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 46,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: images.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.grey,
                dotHeight: 8.0,
                dotWidth: 8.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
