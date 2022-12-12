import 'package:flutter/material.dart';
import 'package:prueba_flutter/data/database/booking_entity.dart';
import 'package:prueba_flutter/ui/pages/global_widgets/confirm_modal.dart';
import 'package:status_alert/status_alert.dart';

showError(BuildContext context, String title) {
  StatusAlert.show(
    context,
    duration: const Duration(seconds: 2),
    title: title,
    subtitle: '',
    configuration: const IconConfiguration(icon: Icons.error),
    maxWidth: 260,
  );
}

Future showConfirm(BuildContext context, String bookingId) async {
  await showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return ConfirmModal(bookingId: bookingId);
    },
  );
}
