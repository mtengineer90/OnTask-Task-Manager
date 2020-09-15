import 'package:flutter/material.dart';
import 'package:ontask/models/icerik.dart';

class Klasor extends Icerik{

  List<Icerik> icerik;

  Klasor(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.folder, renk){
    this.icerik = List<Icerik>();
  }
}