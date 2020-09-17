import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

abstract class Icerik{
  final String id = md5.convert(utf8.encode(DateTime.now().toString())).toString();
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
    if(renk !=null){
      this.renk = renk;
    }
    else{
      this.renk = RenkPaleti.randomColor();
    }

    this.olusturmaZamani=DateTime.now();
    this.sonDegisimZamani=DateTime.now();
    this.silindiMi = false;
  }

  String getBaslik(){
    return baslik;
  }

  String getAciklama();

  Color getRenk() {

    return this.renk;
  }

  Color getIconRenk(){
    return this.renk.computeLuminance()>0.7 ? Colors.black54:Colors.white;
  }

  IconData getIcon();
}