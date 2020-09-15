import 'package:flutter/material.dart';
import 'package:ontask/models/icerik.dart';

class CheckBox extends Icerik{

  bool isChecked;

  CheckBox(baslik, favori, secured, sifre, aciklama, isChecked, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.format_list_bulleted, renk){
    this.isChecked = isChecked;
  }
}