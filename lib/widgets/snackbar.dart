import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/globals.dart';

void showSnackBar( String message) {
  scaffoldMessengerkey.currentState!.showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
