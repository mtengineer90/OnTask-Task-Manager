import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/gorevler.dart';

class Klasor extends Icerik{

  Gorevler icerik;

  Klasor(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.folder, renk){
    this.icerik = Gorevler();
  }

  @override
  String getAciklama() {
    if(secured==true){
      return "Kilitli Klasör";
    }

    return "${this.icerik.length} İçeriği";
  }

  @override
  IconData getIcon() {
    if(secured==true){
      return EkleIcon.kilit;
    }

    if(icerik.length > 1) {
      return EkleIcon.klasor;
    }
    else {
      return EkleIcon.klasor;
    }
  }
}