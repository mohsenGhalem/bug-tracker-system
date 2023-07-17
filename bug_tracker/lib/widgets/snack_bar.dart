import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar buildSnackBar(String title, Color color) {
  return GetSnackBar(
    
    margin: const EdgeInsets.symmetric(horizontal: 10),
    backgroundColor: color,
    borderRadius: 10,
    duration: const Duration(milliseconds: 1500),
    message: title,
    icon: const Icon(
      Icons.info,
      color: Colors.white,
    ),
  );
}
