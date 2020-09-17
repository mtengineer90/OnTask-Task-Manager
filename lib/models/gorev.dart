import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/ayarlar/sabitler.dart';

class Gorev extends Icerik{
  DateTime editZamani;
  DateTime sonZaman;
  DateTime olusturmaZamani;

  Gorev(baslik, favori, secured, sifre, aciklama, renk, this.sonZaman): super(baslik, favori, secured, sifre, aciklama, Icons.note, renk){
    this.olusturmaZamani=DateTime.now();
    this.editZamani=DateTime.now();
  }

  @override
  String getAciklama() {

    if(secured==true){
      return "Kilitli Görev";
    }

    if(this.sonZaman != null) {
      return "${sonZaman.difference(DateTime.now()).inHours} hours left";
    } else {
      return "Editlendi: ${DateFormat.yMMMd().format(this.editZamani)}";
    }
  }

  @override
  IconData getIcon() {
    if(secured==true){
      return EkleIcon.kilit;
    }
    return EkleIcon.dokuman;
  }
}