import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/ayarlar/sabitler.dart';

class Gorev extends Icerik{

  Gorev(baslik, favori, secured, sifre, aciklama, renk): super(baslik, favori, secured, sifre, aciklama, renk);

  @override
  String getAciklama() {

    if(sifre!=null){
      return "Kilitli Görev";
    }

    if(this.sonZaman != null) {
      return "${sonZaman.difference(DateTime.now()).inHours} saat kaldı...";
    } else {
      return "Editlendi: ${DateFormat.yMMMd().format(this.sonDegisimZamani)}";
    }
  }

  @override
  IconData getIcon() {
    if(sifre!=null){
      return EkleIcon.kilit;
    }
    return EkleIcon.dokuman;
  }
}