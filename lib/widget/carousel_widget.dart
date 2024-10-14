import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:findyourdresse_app/widget/video_player_item.dart';

import '../routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/enum.dart';

class CarouselWidget extends StatefulWidget {
  ///value3 is the playbackId
  final List<dartz.Tuple3<String, FileType, String?>> pictures;
  final String? tag;

  const CarouselWidget({Key? key, required this.pictures, this.tag}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  PageController controller = PageController(
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
          height: formatHeight(237),
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount: widget.pictures.length,
            itemBuilder: ((context, index, _) {
              return InkWell(
                onTap: () {
                  if (widget.pictures[index].value2 == FileType.video) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPlayerMedia(
                                url: "https://stream.mux.com/${widget.pictures[index].value3!}.m3u8")));
                    return;
                  }
                  AutoRouter.of(context).navigate(FullCarouselWidget(pictures: widget.pictures, index: index));
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: formatHeight(237),
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.pictures[index].value1,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Center(
                          child: LoaderClassique(),
                        ),
                        errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    if (widget.pictures[index].value2 == FileType.video)
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        top: 0,
                        left: 0,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                  ],
                ),
              );
            }),
            options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              height: double.infinity,
              // aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmoothIndicator(
              size: const Size(5, 5),
              offset: _currentIndex * 1.0,
              count: widget.pictures.length,
              effect: JumpingDotEffect(
                paintStyle: PaintingStyle.stroke,
                dotHeight: formatHeight(5),
                dotWidth: formatWidth(5),
                activeDotColor: Colors.black,
                dotColor: Colors.grey,
                jumpScale: .7,
                verticalOffset: 15,
              ), // your preferred effect
              onDotClicked: (index) {},
            ),
          ],
        ),
      ],
    );
  }
}
