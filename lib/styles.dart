// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

abstract class Styles {
  static const Color primaryColor = Color(0xFF0f0a0a);
  static const Color primaryContrastingColor = Color(0xFF8d99ae);
  static const Color barBackgroundColor = Color(0xFFEDF2F4);
  static const Color scaffoldBackgroundColor = Color(0xFFEDF2F4);
  static const Color primaryTextColor = Color(0xFF29339B);
  static const Color secondaryTextColor = Color(0xFF60935D);
  static const Color primaryButtonColor = Color(0xFFA98743);
  static const Color deleteRed = Color(0xFFF87575);
  static const Color faveYellow = Color(0xFFF3B61F);

  static const Alignment centerLeft = Alignment(-0.95, 0.0);
  static const Alignment centerRight = Alignment(0.95, 0.0);

  static const TextStyle productRowItemName = TextStyle(
    color: primaryTextColor,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productRowTotal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productRowItemPrice = TextStyle(
    color: secondaryTextColor,
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );
}
