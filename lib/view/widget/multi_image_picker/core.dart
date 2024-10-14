// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_kosmos/core_package.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/controller/storage_controller.dart';
import 'package:findyourdresse_app/model/product_media/product_media.dart';
import 'package:findyourdresse_app/view/widget/multi_image_picker/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:findyourdresse_app/utils/enum.dart';

import 'package:reorderables/reorderables.dart';

/// {@category Widget}
/// **/!\ Only for IOS and Android /!\**
///
class MultiImagePicker extends StatefulWidget {
  final int maxItem;

  final String? fieldName;
  final TextStyle? fieldNameStyle;
  final List<dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?>>? initialValue;
  final List<dartz.Tuple3<File, FileType, Uint8List?>>? initialUrl;

  /// Theme
  final Color? deleteButtonColor;
  final double? itemSpacing;
  final double? itemRunSpacing;
  final EdgeInsetsGeometry? imageBoxPadding;
  final BorderRadiusGeometry? imageBoxBorderRadius;
  final Color? imageBoxColor;
  final double? imageBoxWidth;
  final double? imageBoxHeight;

  final String? themeName;
  final MultiImagePickerThemeData? theme;

  const MultiImagePicker({
    Key? key,
    this.maxItem = 8,
    this.themeName,
    this.theme,
    this.deleteButtonColor,
    this.itemRunSpacing,
    this.itemSpacing,
    this.imageBoxBorderRadius,
    this.imageBoxPadding,
    this.imageBoxColor,
    this.imageBoxHeight,
    this.imageBoxWidth,
    this.fieldName,
    this.fieldNameStyle,
    this.initialValue,
    this.initialUrl,
  }) : super(key: key);

  @override
  State<MultiImagePicker> createState() => MultiImagePickerState();
}

class MultiImagePickerState extends State<MultiImagePicker> {
  late final MultiImagePickerThemeData? _themeData;

  List<dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?>> _images = [];

  @override
  void initState() {
    _themeData = loadThemeData(
        widget.theme, widget.themeName ?? "multi_image_picker", (() => const MultiImagePickerThemeData()));
    _images = widget.initialValue != null ? [...widget.initialValue!] : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldName != null) ...[
          Text(
            widget.fieldName!,
            style: widget.fieldNameStyle ??
                const TextStyle(color: Color(0xFF02132B), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          sh(12),
        ],
        ReorderableWrap(
          spacing: widget.itemSpacing ?? _themeData?.itemSpacing ?? formatWidth(25),
          runSpacing: widget.itemRunSpacing ?? _themeData?.itemRunSpacing ?? formatHeight(15),
          children: [for (int i = 0; i < widget.maxItem; i++) _buildImageBox(i)],
          onReorder: (firstPos, endPos) {
            setState(() {
              final dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?> firstItem = _images[firstPos];
              _images.removeAt(firstPos);
              if (endPos > _images.length) {
                _images.insert(_images.length, firstItem);
              } else {
                _images.insert(endPos, firstItem);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildImageBox(int index) {
    final dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?>? image =
        index < _images.length ? _images[index] : null;

    return InkWell(
      onTap: () async {
        if (image == null) {
          await _pickImages(context);
        }
      },
      child: Container(
        width: widget.imageBoxWidth ?? _themeData?.imageBoxWidth ?? formatWidth(142),
        height: widget.imageBoxHeight ?? _themeData?.imageBoxHeight ?? formatHeight(183),
        padding: widget.imageBoxPadding ?? _themeData?.imageBoxPadding ?? EdgeInsets.all(formatWidth(6)),
        decoration: BoxDecoration(
          borderRadius:
              widget.imageBoxBorderRadius ?? _themeData?.imageBoxBorderRadius ?? BorderRadius.circular(formatWidth(7)),
          color: widget.imageBoxColor ?? _themeData?.imageBoxColor ?? const Color(0xFFF7F7F8),
        ),
        clipBehavior: Clip.none,
        child: image != null
            ? Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: widget.imageBoxWidth ?? _themeData?.imageBoxWidth ?? formatWidth(142),
                    height: widget.imageBoxHeight ?? _themeData?.imageBoxHeight ?? formatHeight(183),
                    decoration: BoxDecoration(
                      borderRadius: widget.imageBoxBorderRadius ??
                          _themeData?.imageBoxBorderRadius ??
                          BorderRadius.circular(formatWidth(7)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: widget.imageBoxWidth ?? _themeData?.imageBoxWidth ?? formatWidth(142),
                          height: widget.imageBoxHeight ?? _themeData?.imageBoxHeight ?? formatHeight(183),
                          child: image.value2 == FileType.image
                              ? image.value1 != null
                                  ? Image.file(image.value1!, fit: BoxFit.cover)
                                  : CachedNetworkImage(imageUrl: image.value4!.url!, fit: BoxFit.cover)
                              : Stack(
                                  children: [
                                    image.value3 == null
                                        ? image.value1 != null
                                            ? Positioned.fill(child: Image.file(image.value1!, fit: BoxFit.cover))
                                            : image.value4!.playBackId != null
                                                ? Positioned.fill(
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://image.mux.com/${image.value4!.playBackId!}/thumbnail.png?width=400",
                                                        fit: BoxFit.cover))
                                                : const SizedBox()
                                        : Positioned.fill(child: Image.memory(image.value3!, fit: BoxFit.cover)),
                                    Center(
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: formatWidth(30),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        Positioned(
                          top: formatHeight(-3),
                          left: formatWidth(-6),
                          child: SvgPicture.asset("assets/svg/ic_slide.svg"),
                        ),
                        Positioned(
                          bottom: formatHeight(5),
                          left: formatWidth(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(formatWidth(100)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: formatWidth(10), vertical: formatHeight(3)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(formatWidth(100)),
                                ),
                                child: Text(
                                  "utils.number_x".tr(args: [(index + 1).toString()]),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sp(9)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -14,
                    right: -14,
                    child: Listener(
                      behavior: HitTestBehavior.translucent,
                      onPointerUp: (_) {
                        setState(() {
                          _images.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: AbsorbPointer(
                          child: Container(
                            width: formatWidth(18),
                            height: formatWidth(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEB5353),
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(formatWidth(20)),
                            ),
                            child:
                                Center(child: Icon(Icons.remove_rounded, color: Colors.white, size: formatWidth(13))),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Icon(
                  Icons.add_rounded,
                  color: const Color(0xFF9299A4),
                  size: formatWidth(45),
                ),
              ),
      ),
    );
  }

  List<dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?>> getPickedImages() => _images;

  _pickImages(BuildContext context) async {
    dartz.Tuple3<XFile, FileType, Uint8List?>? image = await StorageController.selectMedia(context);
    if (image != null) {
      dartz.Tuple4<File?, FileType, Uint8List?, ProductMedia?> _ =
          dartz.Tuple4(File(image.value1.path), image.value2, image.value3, null);
      setState(() {
        _images.add(_);
      });
    }
  }
}
