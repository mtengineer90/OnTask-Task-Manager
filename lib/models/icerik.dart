import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Icerik{
  String baslik;
  bool favori;
  bool secured;
  String sifre;
  String aciklama;
  IconData icon;
  Color renk;

  Icerik(baslik, favori, secured, sifre, aciklama, icon, renk){
    this.baslik;
    this.favori;
    this.secured;
    this.sifre;
    this.aciklama;
    this.icon;
    this.renk;
  }
}