import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:findyourdresse_app/widget/video_player_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "../utils/enum.dart";

class FullCarouselWidget extends ConsumerStatefulWidget {
  final List<Tuple3<String, FileType, String?>> pictures;
  final int index;
  const FullCarouselWidget({required this.pictures, required this.index, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FullCarouselWidgetState();
}

class _FullCarouselWidgetState extends ConsumerState<FullCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => AutoRouter.of(context).navigateBack(),
          ),
          backgroundColor: Colors.black),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height, viewportFraction: 1.0, enlargeCenterPage: false, initialPage: widget.index,
              enableInfiniteScroll: false,
              // autoPlay: false,
            ),
            items: widget.pictures
                .map((item) => Center(
                        child: InkWell(
                      onTap: item.value2 == FileType.image
                          ? null
                          : () {
                              if (item.value2 == FileType.video) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlayerMedia(url: "https://stream.mux.com/${item.value3!}.m3u8")));
                              }
                            },
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.value1,
                            fit: BoxFit.contain,
                            height: height,
                          ),
                          Center(
                            child: item.value2 == FileType.video
                                ? const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                : const SizedBox(),
                          )
                        ],
                      ),
                    )))
                .toList(),
          );
        },
      ),
    );
  }
}
