import 'dart:io';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_list/dress_type.dart';
import 'package:findyourdresse_app/model/product_media/product_media.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/form/product_form_provider.dart';
import 'package:findyourdresse_app/provider/product_provider.dart';
import 'package:findyourdresse_app/services/mux_serivces.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:findyourdresse_app/view/widget/multi_image_picker/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multiselect/multiselect.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import '../../../../controller/storage_controller.dart';

class CreateProductPage extends ConsumerStatefulWidget {
  final String? productId;
  const CreateProductPage({super.key, @QueryParam('productId') this.productId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends ConsumerState<CreateProductPage> {
  final GlobalKey<MultiImagePickerState> _multiImagePickerKey = GlobalKey<MultiImagePickerState>();
  final ScrollController reorderScrollController = ScrollController();
  final GlobalKey<FormState> _formKeyProduct = GlobalKey<FormState>();

  final PageController _controller = PageController();
  final List<ProductMedia> urls = [];
  List<Tuple4<File?, FileType, Uint8List?, ProductMedia?>> images = [];
  ProductModel? product;
  Future<List<Tuple3<File?, FileType, ProductMedia?>>>? future;

  Morphology? morphology;

  @override
  void initState() {
    if (widget.productId != null) {
      initProduct();
    }
    super.initState();
  }

  initProduct() async {
    future = getImages();
    setState(() {});
  }

  Future<List<Tuple3<File?, FileType, ProductMedia?>>> getImages() async {
    final List<Tuple3<File?, FileType, ProductMedia?>> tmp = [];
    product = ref.read(productProvider).getProductById(widget.productId!)!;
    for (var media in product!.productMedias!) {
      tmp.add(Tuple3(null, FileType.image, media));
    }

    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Form(
          key: _formKeyProduct,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sh(52),
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Text(
                          product == null ? 'title.form-product-title'.tr() : 'title.modification-product-title'.tr(),
                          style: AppThemeStyle.descriptionSubtitle.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(20, 0),
                        child: CTA.back(
                          height: 50,
                          width: 50,
                          onTap: () {
                            AutoRouter.of(context).navigateBack();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: formatWidth(29)),
                  child: Column(
                    children: [
                      sh(45),
                      TextFormUpdated.classic(
                        fieldNameStyle: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                        defaultValue: ref.watch(productFormProvider).name ?? product?.name,
                        fieldName: 'field.product-name'.tr(),
                        hintText: 'field.product-name-hint'.tr(),
                        onChanged: (val) {
                          ref.read(productFormProvider).setName(val);
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'field.product-name-validator'.tr();
                          }
                          return null;
                        },
                      ),
                      sh(14),
                      TextFormUpdated.classic(
                        fieldNameStyle: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                        defaultValue: ref.watch(productFormProvider).price ?? product?.price,
                        fieldName: 'field.product-price'.tr(),
                        hintText: 'field.product-price-hint'.tr(),
                        textInputType: TextInputType.number,
                        onChanged: (val) {
                          ref.read(productFormProvider).setPrice(val);
                        },
                      ),
                      sh(14),
                      Row(
                        children: [
                          Text(
                            'content.robe-type'.tr(),
                            style: TextStyle(
                                color: const Color(0xFF02132B), fontSize: sp(12), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      sh(6),
                      FormField<List<String>>(validator: (value) {
                        if (ref.watch(productFormProvider).type.isNotEmpty ||
                            product?.type != null && product!.type!.isNotEmpty) {
                          return null;
                        } else {
                          return 'content.error-robe-type'.tr();
                        }
                      }, builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(Colors.transparent)),
                                checkboxTheme: CheckboxThemeData(
                                  fillColor: MaterialStateProperty.all(AppColor.linearFirst),
                                  checkColor: MaterialStateProperty.all(Colors.white),
                                  side: const BorderSide(color: Colors.black),
                                ),
                              ),
                              child: DropDownMultiSelect(
                                hint: Text("content.robe-type-hint".tr()),
                                hintStyle: const TextStyle(
                                    color: Color(0xff868E99),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'),
                                selected_values_style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'),
                                onChanged: (List<String> x) {
                                  ref.read(productFormProvider).setType(x);
                                  setState(() {
                                    state.didChange(x);
                                  });
                                },
                                icon: const Icon(Iconsax.arrow_down_14),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0XFF02132B).withOpacity(0.03),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: formatHeight((17 +
                                              max(
                                                  0,
                                                  (product?.type != null && product!.type!.isNotEmpty
                                                          ? product!.type!.length
                                                          : ref.watch(productFormProvider).type.length) *
                                                      3)) *
                                          1),
                                      horizontal: formatWidth(22)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: state.hasError ? Colors.red.withOpacity(0.8) : Colors.transparent,
                                    width: formatHeight(0.5),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: formatHeight(0.5),
                                    ),
                                  ),
                                ),
                                options: Dress.type,
                                selectedValues: product?.type != null && product!.type!.isNotEmpty
                                    ? product!.type!
                                    : ref.watch(productFormProvider).type,
                              ),
                            ),
                            if (state.hasError) ...[
                              Padding(
                                padding: EdgeInsets.only(top: formatHeight(5), left: formatWidth(22)),
                                child: Text(state.errorText!, style: AppThemeStyle.errorText),
                              )
                            ],
                          ],
                        );
                      }),
                      sh(14),
                      Row(
                        children: [
                          Text(
                            'content.size-input'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      sh(6),
                      FormField<List<String>>(validator: (value) {
                        if (ref.watch(productFormProvider).size.isNotEmpty ||
                            product?.size != null && product!.size!.isNotEmpty) {
                          return null;
                        } else {
                          return 'content.error-robe-type'.tr();
                        }
                      }, builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(Colors.transparent)),
                                checkboxTheme: CheckboxThemeData(
                                  fillColor: MaterialStateProperty.all(AppColor.linearFirst),
                                  checkColor: MaterialStateProperty.all(Colors.white),
                                  side: const BorderSide(color: Colors.black),
                                ),
                              ),
                              child: DropDownMultiSelect(
                                  hint: Text("content.robe-type-hint".tr()),
                                  hintStyle: const TextStyle(
                                      color: Color(0xff868E99),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                  selected_values_style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                  onChanged: (List<String> x) {
                                    ref.read(productFormProvider).setSize(x);
                                    setState(() {
                                      state.didChange(x);
                                    });
                                  },
                                  icon: const Icon(Iconsax.arrow_down_14),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0XFF02132B).withOpacity(0.03),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: formatHeight((17 +
                                                max(
                                                    0,
                                                    (product?.size != null && product!.size!.isNotEmpty
                                                                ? product!.size!
                                                                : ref.watch(productFormProvider).size)
                                                            .length *
                                                        1.2)) *
                                            1),
                                        horizontal: formatWidth(22)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: state.hasError ? Colors.red.withOpacity(0.8) : Colors.transparent,
                                      width: formatHeight(0.5),
                                    )),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.r),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: formatHeight(0.5),
                                      ),
                                    ),
                                  ),
                                  options: [
                                    for (var i = 32; i <= 56; i += 2) ...{i.toString()},
                                  ],
                                  selectedValues: product?.size != null && product!.size!.isNotEmpty
                                      ? product!.size!
                                      : ref.watch(productFormProvider).size),
                            ),
                            if (state.hasError) ...[
                              Padding(
                                padding: EdgeInsets.only(top: formatHeight(5), left: formatWidth(22)),
                                child: Text(state.errorText!, style: AppThemeStyle.errorText),
                              )
                            ],
                          ],
                        );
                      }),
                      sh(14),
                      Row(
                        children: [
                          Text(
                            'field.picture'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      sh(6),
                      FormField(validator: (value) {
                        if (images.isNotEmpty || product?.productMedias != null && product!.productMedias!.isNotEmpty) {
                          return null;
                        } else {
                          return 'content.error-image'.tr();
                        }
                      }, builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                _controller.jumpToPage(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.backGrey,
                                    borderRadius: BorderRadius.circular(7.r),
                                    border: Border.all(
                                        color: state.hasError ? Colors.redAccent : Colors.transparent,
                                        width: formatWidth(.5))),
                                height: formatHeight(54),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('field.add-picture'.tr()),
                                    SvgPicture.asset("assets/svg/arrow_right_inc.svg")
                                  ],
                                ),
                              ),
                            ),
                            if (state.hasError) ...[
                              Padding(
                                padding: EdgeInsets.only(top: formatHeight(5), left: formatWidth(22)),
                                child: Text(state.errorText!, style: AppThemeStyle.errorText),
                              )
                            ]
                          ],
                        );
                      }),
                      sh(14),
                      TextFormUpdated.textarea(
                        fieldNameStyle: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                        initialValue: ref.watch(productFormProvider).description ?? product?.description,
                        fieldName: 'field.product-description'.tr(),
                        hintText: 'field.product-description-hint'.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field.product-description-validator'.tr();
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          ref.read(productFormProvider).setDescription(val);
                        },
                        maxLine: 5,
                      ),
                      sh(35),
                      CTA.primary(
                        textButton: product == null ? 'field.product-create'.tr() : 'field.product-modify'.tr(),
                        onTap: () async {
                          if (_formKeyProduct.currentState!.validate() && images.isNotEmpty ||
                              widget.productId != null) {
                            if (product != null) {
                              if (images.isNotEmpty) {
                                await uploadImage(product!.id!);
                              } else {
                                null;
                              }
                              ref.read(productProvider).updateProduct(
                                      product: ProductModel(
                                    id: product!.id,
                                    type: ref.watch(productFormProvider).type.isNotEmpty
                                        ? ref.read(productFormProvider).type
                                        : product!.type,
                                    size: ref.watch(productFormProvider).size.isNotEmpty
                                        ? ref.read(productFormProvider).size
                                        : product!.size,
                                    ownerId: FirebaseAuth.instance.currentUser!.uid,
                                    name: ref.read(productFormProvider).name ?? product!.name,
                                    description: ref.read(productFormProvider).description ?? product!.description,
                                    city: product!.city,
                                    price: ref.read(productFormProvider).price ?? product!.price,
                                    productMedias: urls.isEmpty ? product!.productMedias : urls,
                                    createdAt: product!.createdAt,
                                  ));
                            } else {
                              String id = FirebaseFirestore.instance.collection("products").doc().id;
                              await uploadImage(id);
                              await ref.read(productProvider).addProduct(
                                  ProductModel(
                                    type: ref.read(productFormProvider).type,
                                    size: ref.read(productFormProvider).size,
                                    ownerId: FirebaseAuth.instance.currentUser!.uid,
                                    name: ref.read(productFormProvider).name,
                                    description: ref.read(productFormProvider).description,
                                    city:
                                        (ref.read(userChangeNotifierProvider).userData! as UserModelFyd).location!.city,
                                    price: ref.read(productFormProvider).price,
                                    productMedias: urls,
                                    createdAt: DateTime.now(),
                                  ),
                                  id);
                            }
                            Utils.notifGreen(
                                context, 'banner.green-product-title'.tr(), 'banner.green-product-subtitle'.tr());
                            AutoRouter.of(context).navigateBack();
                            if (widget.productId == null) {
                              // AutoRouter.of(context).navigateNamed("/dashboard/profil/creator/${FirebaseAuth.instance.currentUser!.uid}");
                            }
                          }
                        },
                      ),
                      sh(14),
                      Text('signalement.footer'.tr(), style: AppThemeStyle.footerSignalenemnt),
                      sh(25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: formatWidth(29)),
          child: Column(
            children: [
              sh(52),
              Row(
                children: [
                  Transform.translate(
                    offset: Offset(-formatWidth(10), 0),
                    child: CTA.back(
                      height: 50,
                      width: 50,
                      onTap: () {
                        _controller.jumpToPage(0);
                      },
                    ),
                  ),
                ],
              ),
              sh(13),
              Text('title.add-picture'.tr(), style: AppThemeStyle.homeSecondTitle),
              sh(8),
              Text(
                'title.add-picture-description'.tr(),
                style: AppThemeStyle.detailSubtitle,
                textAlign: TextAlign.center,
              ),
              sh(20),
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: formatHeight(30)),
                        physics: const BouncingScrollPhysics(),
                        primary: true,
                        child: PrimaryScrollController(
                          controller: reorderScrollController,
                          child: FutureBuilder<List<Tuple3<File?, FileType, ProductMedia?>>>(
                            future: future,
                            builder: (context, snapshot) {
                              if (widget.productId != null) {
                                if (snapshot.hasData) {
                                  return MultiImagePicker(
                                    key: _multiImagePickerKey,
                                    maxItem: 8,
                                    initialValue:
                                        snapshot.data!.map((e) => Tuple4(e.value1, e.value2, null, e.value3)).toList(),
                                  );
                                } else {
                                  return const LoaderClassique();
                                }
                              }
                              return MultiImagePicker(
                                key: _multiImagePickerKey,
                                maxItem: 7,
                                // initialValue: images,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: formatHeight(25),
                      left: 0,
                      right: 0,
                      child: CTA.primary(
                        textButton: 'utils.validate'.tr(),
                        onTap: () async {
                          images = _multiImagePickerKey.currentState!.getPickedImages();

                          if (images.isNotEmpty) {
                            _controller.jumpToPage(0);
                          } else {
                            Utils.notifRed(
                                context, "banner.red-product-title".tr(), "banner.red-product-subtitle".tr());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<ProductMedia>> uploadImage(String productId) async {
    for (final item in images) {
      String? url;
      switch (item.value2) {
        case FileType.image:
          if (item.value4 == null) {
            url = await StorageController.uploadFile(
              refPath: "users/${FirebaseAuth.instance.currentUser!.uid}/product/$productId/images/",
              file: item.value1,
            );
            if (url == null) {
              printInDebug("[Error] Failed to upload image to Firebase Storage");
              continue;
            }
          }
          setState(() {
            urls.add(item.value4 ?? ProductMedia(url: url, fileType: FileType.image));
          });
          break;
        case FileType.video:
          Tuple2<String, String>? _video;
          if (item.value4 == null) {
            _video = await MuxServices.pubVideoToMux(
              file: item.value1!,
            );
            if (_video == null) {
              printInDebug("[Error] Failed to upload video to Mux");
              continue;
            }
            setState(() {
              urls.add(item.value4 ??
                  ProductMedia(
                      url: _video!.value1,
                      playBackId: _video.value2,
                      fileType: FileType.video,
                      assetId: _video.value1));
            });
          }
      }
    }

    // await FirebaseFirestore.instance.collection('products').doc(productId).set({
    //   'productMedias': urls.map((e) => e.toJson()).toList(),
    // }, SetOptions(merge: true));
    return urls;
  }

  @override
  void dispose() {
    future = null;
    super.dispose();
  }
}
