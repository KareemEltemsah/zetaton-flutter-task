import 'package:flutter/material.dart';

class Tools {
  /// function to show SnackBar fro any scaffold
  static showSnackBar(context, message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
