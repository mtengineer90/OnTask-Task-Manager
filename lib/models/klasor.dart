import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/models/icerik.dart';

class Klasor extends Icerik{

  List<Icerik> icerik;

  Klasor(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.folder, renk){
    this.icerik = List<Icerik>();
  }

  @override
  String getAciklama() {
    return "${this.icerik.length} İçeriği";
  }

  @override
  IconData getIcon() {

    if(icerik.length > 1) {
      return EkleIcon.klasor;
    }
    else {
      return EkleIcon.klasor;
    }
  }
}