import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:findyourdresse_app/widget/my_signalment_page/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_signalement/package_signalement.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../config/theme.dart';

enum ReportFrom { reportFromPicture, reportFromUser, reportFromProduct }

class SignalmentPage extends ConsumerStatefulWidget {
  final ReportFrom reportType;
  final ReportType reportType2;
  final String userId;
  final String? itemId;
  const SignalmentPage({
    Key? key,
    required this.reportType,
    required this.reportType2,
    required this.userId,
    this.itemId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignalmentPageState();
}

class _SignalmentPageState extends ConsumerState<SignalmentPage> {
  @override
  Widget build(BuildContext context) {
    dynamic _ = _buildPrecision();
    List<ReportType> values = [];
    if (widget.reportType == ReportFrom.reportFromPicture) {
      values = [ReportType.user, ReportType.picture];
    } else if (widget.reportType == ReportFrom.reportFromUser) {
      values = [ReportType.user];
    } else if (widget.reportType == ReportFrom.reportFromProduct) {
      values = [ReportType.user, ReportType.product];
    }
    List<ItemModel<String>> _list =
        values.map((e) => ItemModel(child: Text(e.label), value: e.label, childField: _)).toList();
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: MySignalementPage<String>(
          showSuccessPage: true,
          value: widget.reportType2.label,
          onPop: () => AutoRouter.of(context).navigateBack(),
          fieldItem: FieldModel(
            items: _list,
            fieldName: "Motif de votre problème*",
            fieldHint: "Choisir",
          ),
          successPageBuilder: (_) => ClampingPage(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: formatWidth(41),
                  height: formatWidth(41),
                  decoration: BoxDecoration(color: AppColor.linearFirst, borderRadius: BorderRadius.circular(100)),
                  child: Center(child: Icon(Icons.check_rounded, color: Colors.white, size: formatWidth(24))),
                ),
                sh(14),
                Text(
                  "Envoyé",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sp(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sh(5),
                Text(
                  "Votre signalement a bien été envoyé ! Il sera traité dans les plus brefs délais.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sp(13),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CTA.primary(
                  textButton: "Terminer",
                  onTap: () => Navigator.of(_).pop(),
                ),
                sh(14),
              ],
            ),
          ),
          validator: (listSelectForms, description, file, _) async {
            if (listSelectForms.length < 2) {
              NotifBanner.showToast(context: context, fToast: FToast().init(context), title: "Remplir les champs");
              return false;
            }
            try {
              String? _downloadUrl;
              if (_?.path != null) {
                UploadTask __ = FirebaseStorage.instance
                    .ref()
                    .child("reports")
                    .child(widget.userId)
                    .child(DateTime.now().toString())
                    .putFile(File(_!.path));
                var x = await (__);
                _downloadUrl = await x.ref.getDownloadURL();
              }
              FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("reports").add({
                "reportType": listSelectForms[0].value2.value,
                "reportMore": listSelectForms[1].value2.value,
                "description": description,
                "image": _downloadUrl ?? "",
                "userId": widget.userId,
                "itemId": widget.itemId,
                "createdAt": DateTime.now(),
              });
            } catch (e) {}
            return true;
          },
        ),
      ),
    );
  }

  _buildPrecision() {
    return FieldModel(
      items: ReportMore.values.map((e) => ItemModel(child: Text(e.label), value: e.name)).toList(),
      fieldName: "Précisez d'avantage*",
      fieldHint: "Choisir",
    );
  }

  _buildPrecisionOther() {
    return FieldModel(
      items: [
        ItemModel(child: const Text("Pseudo inapproprié"), value: "Pseudo inapproprié"),
      ],
      fieldName: "Précisez d'avantage",
      fieldHint: "Choisir",
    );
  }
}
