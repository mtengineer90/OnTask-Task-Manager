import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';

abstract class Icerik{
  String baslik;
  bool favori;
  bool secured;
  String sifre;
  String aciklama;
  IconData icon;
  Color renk;
  DateTime olusturmaZamani;
  DateTime sonDegisimZamani;
  bool silindiMi;

  Icerik(baslik, favori, secured, sifre, aciklama, icon, renk){
    this.baslik;
    this.favori;
    this.secured;
    this.sifre;
    this.aciklama;
    this.icon;
    this.renk;
    this.olusturmaZamani=DateTime.now();
    this.sonDegisimZamani=DateTime.now();
    this.silindiMi = false;
  }
  String getAciklama();

  Color getRenk() {

    if(this.renk == null) {

      return RenkPaleti.randomColor();
    }

    return this.renk;
  }

  IconData getIcon();
}