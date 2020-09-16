import 'package:flutter/material.dart';
import 'dart:math';

class RenkPaleti {

      static Color colorStart = Colors.blue[900];
      static Color colorEnd = Colors.greenAccent;
      static Color ACIK_KIRMIZI = Color(0xFFff988d);


      static List<Color> LIST_RENKPALET = [
            Color(0xFFFFECE0),
            Color(0xFFE68E84),
            Color(0xFFFDEABF),
            Color(0xFFD4D8FC),

            Color(0xFFECA7F8),
            Color(0xFFF6BCBB),
            Color(0xFFFFD18B),
            Color(0xFF98E8CB),

            Color(0xFFDA6B8C),
            Color(0xFF93BFFE),
            Color(0xFFF7CEB8),
            Color(0xFFF6F2E7),

            Color(0xFFF9DE6A),
            Color(0xFFFFD5BF),
            Color(0xFF6DC9C9),
            Color(0xFFF1F8C5),

            Color(0xFFC6E1CE),
            Color(0xFFD6DFEF),
            Color(0xFFF1B9A3),
            Color(0xFFF8D6ED),
      ];


      static Color randomColor() {
        return RenkPaleti.LIST_RENKPALET[Random().nextInt(RenkPaleti.LIST_RENKPALET.length)];
      }

      static MaterialColor BEYAZ = const MaterialColor(0xFFFFFFFF,
          const {
                50 : const Color(0xFFFFFFFF),
                100 : const Color(0xFFFFFFFF),
                200 : const Color(0xFFFFFFFF),
                300 : const Color(0xFFFFFFFF),
                400 : const Color(0xFFFFFFFF),
                500 : const Color(0xFFFFFFFF),
                600 : const Color(0xFFFFFFFF),
                700 : const Color(0xFFFFFFFF),
                800 : const Color(0xFFFFFFFF),
                900 : const Color(0xFFFFFFFF)
          }
      );

      static MaterialColor KIRMIZI = const MaterialColor(0xf14656FF,
          const {
                50 : const Color(0xf14656FF),
                100 : const Color(0xf14656FF),
                200 : const Color(0xf14656FF),
                300 : const Color(0xf14656FF),
                400 : const Color(0xf14656FF),
                500 : const Color(0xd94568FF),
                600 : const Color(0xd94568FF),
                700 : const Color(0xd94568FF),
                800 : const Color(0xd94568FF),
                900 : const Color(0xd94568FF)
          }
      );

}

class EkleIcon {
  EkleIcon._();

  static const _kFontFam = 'fontA';
  static const _kFontPkg = null;

  static const IconData gorev = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData liste = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData klasor = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData anahtar = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData paylas = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData gonder = IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData ucak = IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData sifre = IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData kilit = IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData edit = IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dokuman = IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData googleDokuman = IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData sayfa = IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}