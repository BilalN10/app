import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';

abstract class BookingController {
  static Future<String?> addBooking(BookingModel booking) async {
    var ref = FirebaseFirestore.instance.collection("bookings").doc();
    await ref.set(booking.copyWith(id: ref.id).toJson());
    return ref.id;
  }

  static Future<void> updateBooking(BookingModel bookingModel) async {
    await FirebaseFirestore.instance.collection("bookings").doc(bookingModel.id).set(bookingModel.toJson());
  }

  // static Future<void> updatePicture(PictureModel picture) async {
  //   FirebaseFirestore.instance.collection("pictures").doc(picture.id).update(picture.toJson());
  // }

  static Future<void> removeBooking(String bookingId, {bool? isCreator}) async {
    await FirebaseFirestore.instance.collection("bookings").doc(bookingId).update({
      "historic": true,
      "state": isCreator == true ? "cancelByCreator" : "cancel",
    });
  }
}
