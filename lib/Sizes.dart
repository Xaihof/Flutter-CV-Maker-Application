import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class Sizes {

  final BuildContext context;

  Sizes(this.context);

  double get Bordersides => MediaQuery.of(context).size.width / 2;

  double get barSize => MediaQuery.of(context).size.width / 5.5;

  double get iconSize => MediaQuery.of(context).size.width / 12;

  double get listiconSize => 20;

  double get imageradius => MediaQuery.of(context).size.width / 8;

  double get radiobuttonsize => MediaQuery.of(context).size.width / 350;

  double get mylisticonSize => MediaQuery.of(context).size.width / 15;

  double get screenWidth => MediaQuery.of(context).size.width;

  // App Colors .........

  Color get AppBartextColor => const Color.fromRGBO(252, 185, 26, 1);

  Color get buttontextColor => Colors.black;

  Color get appIconColor => Colors.black;

  Color? get appBarBgColor =>
      Colors.black; // ? is if gradient like 400 or 500 or 600

  // App Font Sizes ..........

  double get fontSize => MediaQuery.of(context).size.width / 18;

  double get listFontSize => MediaQuery.of(context).size.width / 25;

  double get MainButtonfontSize => MediaQuery.of(context).size.width / 28;

  double get smallfontSize => MediaQuery.of(context).size.width / 32;

  double get paddinghoriyontal => MediaQuery.of(context).size.width / 25;

  double get paddingvertical => MediaQuery.of(context).size.width / 55;

  // PDF Colors and Fonts

  static double _heading = 14;
  static double _subheading = 12;
  static double _paragraph = 10;

  static double get Heading => _heading;

  static double get Subheading => _subheading;

  static double get Paragraph => _paragraph;

  static void increaseHeading() {
    if (_heading < 16) {
      _heading++;
    }
  }

  static void decreaseHeading() {
    if (_heading > 14) {
      _heading--;
    }
  }

  static void increaseSubheading() {
    if (_subheading < 14) {
      _subheading++;
    }
  }

  static void decreaseSubheading() {
    if (_subheading > 12) {
      _subheading--;
    }
  }

  static void increaseParagraph() {
    if (_paragraph < 11) {
      _paragraph++;
    }
  }

  static void decreaseParagraph() {
    if (_paragraph > 10) {
      _paragraph--;
    }
  }

  static Color _bgColor1 = Colors.black;
  static PdfColor _bgColor2 = PdfColors.black;
  static const Color _bgColor3 = Colors.white;
  static const PdfColor _bgColor4 = PdfColors.white;

  PdfColor _IconColor1 = PdfColors.green;
  PdfColor _TextColor1 = PdfColors.black;
  PdfColor _TextColor2 = PdfColors.black;

  static Color get bgColor1 => _bgColor1;

  static PdfColor get bgColor2 => _bgColor2;

  static Color get bgColor3 => _bgColor3;

  static PdfColor get bgColor4 => _bgColor4;

  PdfColor get IconColor1 => _IconColor1;

  PdfColor get TextColor1 => _TextColor1;

  PdfColor get TextColor2 => _TextColor2;

  static void setBgColor1(Color color) {
    _bgColor1 = color;
    _bgColor2 = PdfColor.fromInt(ui.Color(color.value).value);
  }

  void setBgColor2(PdfColor color) {
    _bgColor2 = color;
  }

  void setIconColor1(PdfColor color) {
    _IconColor1 = color;
  }

  void setTextColor1(PdfColor color) {
    _TextColor1 = color;
  }

  void setTextColor2(PdfColor color) {
    _TextColor2 = color;
  }

  static bool template_loading = false;

  static change_flag() {
    template_loading = !template_loading;
  }

  static bool loading = true;

  static changeflag(bool isloading) {
    loading = isloading;
  }
}
