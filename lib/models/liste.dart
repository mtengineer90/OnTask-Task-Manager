import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/ayarlar/sabitler.dart';

class Liste extends Icerik{

  List<CheckBox> listCheckbox;

  Liste(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, Icons.format_list_bulleted, renk){
    this.listCheckbox = List<CheckBox>();
  }
  @override
  String getAciklama() {

    int counterDone = this.listCheckbox.where((cb) => cb.isChecked == true).toList().length;

    return "${this.listCheckbox.length} görevden $counterDone kadar yapıldı.";
  }

  @override
  IconData getIcon() {
    return EkleIcon.liste;
  }
}