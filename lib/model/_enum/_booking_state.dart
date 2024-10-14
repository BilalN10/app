enum BookingState {
  pending,
  creatorDecline,
  validate,
  decline,
  cancel,
  cancelByCreator,
}

// extension NotificationStateExtension on NotificationState {
//   String get label {
//     switch (this) {
//       case NotificationState.pending:
//         return "pend";
//       case NotificationState.validate:
//         return "accepté";
//       case NotificationState.decline:
//         return "refusé";
//       case NotificationState.slotRequest:
//         return "slotRequest";
//       case NotificationState.offertSlot:
//         return "offerSlot";
//       default:
//         return '';
//     }
//   }
// }
