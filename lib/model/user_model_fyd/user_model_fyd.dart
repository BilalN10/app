import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/location_model_new/location_model_new.dart';
import 'package:findyourdresse_app/model/mesurements_model/mesurements_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class UserModelFyd extends UserModel {
  final String? nickname;
  final String? shopNickname;
  final String? type;
  final String? status;
  final bool? premium;
  final String? description;
  final LocationModelNew? location;
  //v1++

  final String? number;
  final String? emailAddress;
  final List<dynamic>? robeType;
  final String? instagram;

  final String? expPro;
  final String? gender;
  final MesurementsModel? mensurations;

  UserModelFyd(
      {String? id,
      String? email,
      String? firstname,
      String? lastname,
      bool? enablePushNotification,
      bool? enableEmailNotification,
      String? fcmToken,
      String? phone,
      String? profilImage,
      String? stripeId,
      String? language,
      bool? cguAccepted,
      bool? profilCompleted,
      bool? isFirstLogin,
      String userType = "default",
      DateTime? createdAt,

      ///Required for Tchat
      String? pseudo,

      ///Required for Position
      GeoPoint? lastKnownPosition,
      DateTime? lastKnownPositionUpdate,
      DateTime? lastSeen,

      //FYD
      this.nickname,
      this.shopNickname,
      this.location,
      this.type,
      this.description,
      //v1++
      this.number,
      this.emailAddress,
      this.robeType,
      this.instagram,
      this.expPro,
      this.gender,
      this.mensurations,
      // this.height,
      // this.size,
      // this.hips,
      // this.bust,
      // this.footSize,
      // this.clothingSize,
      // this.hairColor,
      // this.eyeColor,

      //RevenueCat
      this.status,
      this.premium})
      : super(
          id: id,
          email: email,
          firstname: firstname,
          lastname: lastname,
          enablePushNotification: enablePushNotification,
          enableEmailNotification: enableEmailNotification,
          fcmToken: fcmToken,
          phone: phone,
          profilImage: profilImage,
          stripeId: stripeId,
          language: language,
          cguAccepted: cguAccepted,
          profilCompleted: profilCompleted,
          isFirstLogin: isFirstLogin,
          userType: userType,

          ///Required for Tchat
          pseudo: pseudo,
          createdAt: createdAt,
          lastSeen: lastSeen,

          ///Required for Position
          lastKnownPosition: lastKnownPosition,
          lastKnownPositionUpdate: lastKnownPositionUpdate,
        );

  factory UserModelFyd.fromJson(Map<String, dynamic> json) {
    return UserModelFyd(
      id: json["id"],
      email: json["email"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      enablePushNotification: json["enablePushNotification"],
      enableEmailNotification: json["enableEmailNotification"],
      fcmToken: json["fcmToken"],
      phone: json["phone"],
      profilImage: json["profilImage"],
      stripeId: json["stripeId"],
      language: json["language"],
      cguAccepted: json["cugAccepted"],
      profilCompleted: json["profilCompleted"],
      isFirstLogin: json["isFirstLogin"],
      userType: json["userType"] ?? "default",
      createdAt: (json["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      nickname: json['nickname'],
      shopNickname: json['shopNickname'],
      description: json['description'],
      location: json["location"] != null ? LocationModelNew.fromJson(json["location"]) : null,
      type: json['type'],
      pseudo: json["pseudo"],
      status: json["status"],
      premium: json["premium"],
      lastSeen: (json["lastSeen"] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastKnownPosition: json["lastKnownPosition"],
      lastKnownPositionUpdate: (json["lastKnownPositionUpdate"] as Timestamp?)?.toDate(),
      number: json["number"],
      emailAddress: json["emailAddress"],
      robeType: json["robeType"],
      instagram: json["instagram"],
      expPro: json["expPro"],
      gender: json["gender"],
      mensurations: json["mensurations"] != null ? MesurementsModel.fromJson(json["mensurations"]) : null,
      // height: json["height"],
      // size: json["size"],
      // hips: json["hips"],
      // bust: json["bust"],
      // footSize: json["footSize"],
      // clothingSize: json["clothingSize"],
      // hairColor: json["hairColor"],
      // eyeColor: json["eyeColor"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "enablePushNotification": enablePushNotification,
      "enableEmailNotification": enableEmailNotification,
      "fcmToken": fcmToken,
      "phone": phone,
      "profilImage": profilImage,
      "stripeId": stripeId,
      "language": language,
      "cguAccepted": cguAccepted,
      "profilCompleted": profilCompleted,
      "isFirstLogin": isFirstLogin,
      "userType": userType,
      "createdAt": Timestamp.fromDate(createdAt),
      "nickname": nickname,
      "shopNickname": shopNickname,
      "location": location,
      "type": type,
      "status": status,
      "premium": premium,
      "description": description,
      "pseudo": pseudo,
      "lastSeen": Timestamp.fromDate(lastSeen),
      "lastKnownPosition": lastKnownPosition,
      "lastKnownPositionUpdate": lastKnownPositionUpdate != null ? Timestamp.fromDate(lastKnownPositionUpdate!) : null,
      "number": number,
      "emailAddress": emailAddress,
      "robeType": robeType,
      "instagram": instagram,
      "expPro": expPro,
      "gender": gender,
      "mensurations": mensurations
      // "height": height,
      // "size": size,
      // "hips": hips,
      // "bust": bust,
      // "footSize": footSize,
      // "clothingSize": clothingSize,
      // "hairColor": hairColor,
      // "eyeColor": eyeColor,
    };
  }

  @override
  UserModelFyd copyWith({
    String? id,
    String? email,
    String? firstname,
    String? lastname,
    bool? enablePushNotification,
    bool? enableEmailNotification,
    String? fcmToken,
    String? profilImage,
    String? phone,
    String? stripeId,
    String? language,
    bool? cguAccepted,
    bool? profilCompleted,
    bool? isFirstLogin,
    String? userType,
    DateTime? createdAt,
    String? nickname,
    String? shopNickname,
    LocationModelNew? location,
    String? type,
    String? status,
    bool? premium,
    String? pseudo,
    String? description,
    DateTime? lastSeen,
    GeoPoint? lastKnownPosition,
    DateTime? lastKnownPositionUpdate,
    String? number,
    String? emailAddress,
    List<String>? robeType,
    String? instagram,
    String? expPro,
    String? gender,
    MesurementsModel? mensurations,
    // String? height,
    // String? size,
    // String? hips,
    // String? bust,
    // String? footSize,
    // String? clothingSize,
    // String? hairColor,
    // String? eyeColor,
  }) {
    return UserModelFyd(
        id: id ?? this.id,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        enablePushNotification: enablePushNotification ?? this.enablePushNotification,
        enableEmailNotification: enableEmailNotification ?? this.enableEmailNotification,
        fcmToken: fcmToken ?? this.fcmToken,
        phone: phone ?? this.phone,
        profilImage: profilImage ?? this.profilImage,
        stripeId: stripeId ?? this.stripeId,
        language: language ?? this.language,
        cguAccepted: cguAccepted ?? this.cguAccepted,
        profilCompleted: profilCompleted ?? this.profilCompleted,
        isFirstLogin: isFirstLogin ?? this.isFirstLogin,
        userType: userType ?? this.userType,
        createdAt: createdAt ?? this.createdAt,
        nickname: nickname ?? this.nickname,
        shopNickname: shopNickname ?? this.shopNickname,
        location: location ?? this.location,
        type: type ?? this.type,
        status: status ?? this.status,
        premium: premium ?? this.premium,
        description: description ?? this.description,
        pseudo: pseudo ?? this.pseudo,
        lastSeen: lastSeen ?? this.lastSeen,
        lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
        lastKnownPositionUpdate: lastKnownPositionUpdate ?? this.lastKnownPositionUpdate,
        number: number ?? this.number,
        emailAddress: emailAddress ?? this.emailAddress,
        robeType: robeType ?? this.robeType,
        instagram: instagram ?? this.instagram,
        expPro: expPro ?? this.expPro,
        gender: gender ?? this.gender,
        mensurations: mensurations ?? this.mensurations
        // height: height ?? this.height,
        // size: size ?? this.size,
        // hips: hips ?? this.hips,
        // bust: bust ?? this.bust,
        // footSize: footSize ?? this.footSize,
        // clothingSize: clothingSize ?? this.clothingSize,
        // hairColor: hairColor ?? this.hairColor,
        // eyeColor: eyeColor ?? this.eyeColor,
        );
  }
}
