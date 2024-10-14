import 'dart:async';
import 'dart:io';

import 'package:core_kosmos/core_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_signalement/src/model/signalement_fields.dart';
import 'package:package_signalement/src/core/pages/signalement_submited.dart';
import 'package:package_signalement/src/model/theme/signalement_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_kosmos_v4/ui_kosmos_v4.dart';
import 'package:dartz/dartz.dart' as dz;

enum FileType {
  file,
  image,
}

/// {@category Widget}
/// {@category Page}
/// Page formulaire de signalement à customiser avec vos propres champs ([FieldModel])
class MySignalementPage<T> extends StatefulWidget {
  const MySignalementPage({
    Key? key,
    this.onPop,
    required this.value,
    this.signalementTheme,
    this.signalementThemeName,
    this.title,
    this.subtitle,
    this.footer,
    this.validateText,
    this.showDescriptionReport = true,
    this.showFileReport = true,
    this.fileFieldname,
    this.descriptionFieldname,
    this.svgIconPath,
    this.descriptionHint,
    required this.fieldItem,
    required this.validator,
    this.showSuccessPage = true,
    this.successPageBuilder,
    this.fileType = FileType.image,
    this.selectorIconPath,
    this.warningText,
  }) : super(key: key);

  final FileType fileType;
  final String? svgIconPath;
  final String? selectorIconPath;
  final String value;

  /// Fonction lorsque le bouton de retour est appuyé
  final VoidCallback? onPop;

  /// ThemeData
  final SignalementThemeData? signalementTheme;

  /// ThemeName
  final String? signalementThemeName;

  /// Titre de la page
  final String? title;

  /// Sous-Titre de la page
  final String? subtitle;

  /// Text de fin de page
  final String? footer;

  final String? warningText;

  /// Text du bouto de validation
  final String? validateText;

  /// Champ de description du signalement ou non
  final bool showDescriptionReport;

  /// Champ d'import de fichier d'appuis du signalement ou non
  final bool showFileReport;

  /// Model du champ de selection à choix multiples
  final FieldModel<T> fieldItem;

  /// Fonction de validation du remplissage de formulaire
  final FutureOr<bool> Function(List<dz.Tuple2<int, ItemModel<T>>> listSelectForms, String? description,
      PlatformFile? file, XFile? pickedFile) validator;

  final String? descriptionFieldname;
  final String? descriptionHint;
  final String? fileFieldname;
  final bool showSuccessPage;
  final Widget Function(BuildContext)? successPageBuilder;

  @override
  State<MySignalementPage<T>> createState() => _MySignalementPageState<T>();
}

class _MySignalementPageState<T> extends State<MySignalementPage<T>> {
  List<dz.Tuple2<int, ItemModel<T>>> listSelectForms = [];

  String? description;
  PlatformFile? file;
  XFile? xfile;

  @override
  void initState() {
    super.initState();
    listSelectForms = List.from([
      dz.Tuple2<int, ItemModel<T>>(
          0, widget.fieldItem.items.firstWhere((element) => element.value == widget.value as T)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final SignalementThemeData themeData = loadThemeData(
      widget.signalementTheme,
      widget.signalementThemeName ?? "signalement_page",
      () => const SignalementThemeData(),
    )!;

    printInDebug(listSelectForms);
    List<Widget> fields = [];
    for (final item in listSelectForms) {
      if (item.value2.childField != null) {
        final FieldModel<T> tmpItem = item.value2.childField!;
        printInDebug("add item: $tmpItem");
        fields.add(
          SelectForm<T>(
            prefixChild: widget.selectorIconPath != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(widget.selectorIconPath!),
                    ],
                  )
                : null,
            fieldName: tmpItem.fieldName,
            fieldNameStyle: TextStyle(fontSize: sp(15), fontWeight: FontWeight.w600),
            hintText: tmpItem.fieldHint,
            items: tmpItem.items.map((e) => DropdownMenuItem<T>(value: e.value, child: e.child)).toList(),
            onChangedSelect: (value) {
              listSelectForms.removeWhere((element) => element.value1 > item.value1);
              listSelectForms.add(dz.Tuple2<int, ItemModel<T>>(
                  item.value1 + 1, tmpItem.items.firstWhere((element) => element.value == value)));
              setState(() {});
            },
          ),
        );
        fields.add(sh(20));
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: formatHeight(20)),
                  Padding(
                    padding: EdgeInsets.only(left: formatWidth(10)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CTA.back(
                        theme: themeData.themeBack,
                        themeName: themeData.themeNameBack,
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: formatWidth(29)),
                    child: Column(
                      children: [
                        SizedBox(height: formatHeight(32)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title ?? "signalement.page-title".tr(),
                            style: themeData.titleStyle ??
                                TextStyle(
                                    color: const Color(0xFF02132B),
                                    fontSize: sp(24),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'PlayfairDisplay'),
                          ),
                        ),
                        SizedBox(height: formatHeight(9)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.subtitle ?? "signalement.page-subtitle".tr(),
                            style: themeData.subtitleStyle ??
                                TextStyle(
                                  color: const Color(0xFF02132B).withOpacity(0.65),
                                  fontSize: sp(13),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        SizedBox(height: formatHeight(18)),
                        SelectForm<T>(
                          value: widget.value as T,
                          prefixChild: widget.selectorIconPath != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SvgPicture.asset(widget.selectorIconPath!),
                                  ],
                                )
                              : null,
                          fieldName: widget.fieldItem.fieldName,
                          hintText: widget.fieldItem.fieldHint,
                          fieldNameStyle: TextStyle(fontSize: sp(15), fontWeight: FontWeight.w600),
                          items: widget.fieldItem.items
                              .map((e) => DropdownMenuItem<T>(value: e.value, child: e.child))
                              .toList(),
                          onChangedSelect: (value) {
                            // listSelectForms.removeWhere((element) => element.value1 >= 0);
                            listSelectForms.clear();
                            listSelectForms = List.from([
                              dz.Tuple2<int, ItemModel<T>>(
                                  0, widget.fieldItem.items.firstWhere((element) => element.value == value)),
                            ]);
                            printInDebug(listSelectForms);
                            setState(() {});
                          },
                        ),
                        sh(20),
                        ...fields,
                        if (widget.showDescriptionReport) ...[
                          TextFormUpdated.textarea(
                            theme: themeData.themeDescription,
                            hintText: widget.descriptionHint ?? "signalement.description.hint".tr(),
                            fieldName: widget.descriptionFieldname ?? "signalement.description.field-name".tr(),
                            fieldNameStyle: TextStyle(fontSize: sp(15), fontWeight: FontWeight.w600),
                            onChanged: (str) => description = str,
                          ),
                          sh(20),
                        ],
                        if (widget.showFileReport) ...[
                          if (widget.fileType == FileType.file)
                            Input.validatedFile(
                              svgIconPath: widget.svgIconPath,
                              height: formatHeight(180),
                              onChanged: (p0) => file = p0,
                              fieldName: widget.fileFieldname ?? "signalement.file.field-name".tr(),
                            )
                          else
                            Input.image(
                              svgIconPath: widget.svgIconPath,
                              contentPadding: const EdgeInsets.fromLTRB(7, 6, 30, 6),
                              fieldNameStyle: TextStyle(fontSize: sp(15), fontWeight: FontWeight.w600),
                              onTap: () async {
                                int? val = await showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => CupertinoActionSheet(
                                    title: Text('utils.what-do'.tr()),
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.pop(context, null);
                                      },
                                      child: Text('utils.cancel'.tr()),
                                    ),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context, 1);
                                        },
                                        child: Text('signalement.pick-camera'.tr()),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context, 2);
                                        },
                                        child: Text('signalement.pick-galery'.tr()),
                                      ),
                                    ],
                                  ),
                                );

                                if (val == null) return;

                                PermissionStatus status =
                                    val == 1 ? await Permission.camera.status : await Permission.photos.status;
                                if (status.isDenied) {
                                  val == 1 ? await Permission.camera.request() : await Permission.photos.request();
                                } else if (status.isPermanentlyDenied) {
                                  await showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text(val == 1 ? "Camera permission" : "Photos permission"),
                                        content: Text(
                                            'Please accept the ${val == 1 ? "camera permission" : "photos permission"} in settings to select a photo.'),
                                        actions: [
                                          CupertinoDialogAction(
                                            onPressed: () async {
                                              await openAppSettings();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Open app settings'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                ImagePicker picker = ImagePicker();
                                xfile =
                                    await picker.pickImage(source: val == 1 ? ImageSource.camera : ImageSource.gallery);
                                setState(() {});
                              },
                              imageMobile: xfile != null ? File(xfile!.path) : null,
                              onChanged: (p0) => file = p0,
                              fieldName: widget.fileFieldname ?? "signalement.file.field-name".tr(),
                            ),
                          sh(20),
                        ],
                        sh(20),
                        Text(
                          widget.warningText ?? "",
                          style: TextStyle(color: const Color(0xFF737D8A), fontSize: sp(13)),
                          textAlign: TextAlign.center,
                        ),
                        sh(20),
                        CTA.primary(
                          textButton: widget.validateText ?? "signalement.submit-button".tr(),
                          theme: themeData.themeValidate,
                          themeName: themeData.themeNameValidate,
                          onTap: () async {
                            final res = await widget.validator(listSelectForms, description, file, xfile);

                            printInDebug(res);
                            // if (res) widget.onPop?.call();
                            if (res && widget.showSuccessPage) {
                              printInDebug("show signalement success page");
                              execAfterBuild(() {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      body: SafeArea(
                                        child: SubmitedPage(
                                            theme: themeData, successPageBuilder: widget.successPageBuilder),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                        Column(
                          children: [
                            SizedBox(height: formatHeight(12)),
                            Text(
                              widget.footer ?? "signalement.footer".tr(),
                              style: themeData.footerStyle ??
                                  TextStyle(
                                    color: const Color(0xFF02132B).withOpacity(0.75),
                                    fontSize: sp(12),
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: formatHeight(24)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void fooBuilder(int level, model) {
  //   if (/*Tuple2 Dartz*/ list.length >= level && list.where(e => e.value1 == level + 1).isNotEmpty) {
  //     fooBuilder(level + 1, list.where(e => e.value1 == level + 1).first);
  //   }
  // }
}
