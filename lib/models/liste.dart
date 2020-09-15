import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';

class Liste extends Icerik{
  List<Checkbox> listCheckbox;

  Liste(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.format_list_bulleted, renk){
    this.listCheckbox = List<Checkbox>();
  }
}