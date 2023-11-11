import 'package:flutter/material.dart';

class Tools {
  static showSnackBar(context, message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
