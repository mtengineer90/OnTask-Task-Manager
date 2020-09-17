import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:share/share.dart';

class Liste extends Icerik{

  List<CheckBox> listCheckbox;

  Liste(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, renk){
    this.listCheckbox = List<CheckBox>();
  }
  @override
  String getAciklama() {
    if(sifre!=null){
      return "Kilitli Liste";
    }

    int counterDone = this.listCheckbox.where((cb) => cb.isChecked == true).toList().length;

    return "${this.listCheckbox.length} görevden $counterDone kadar yapıldı.";
  }

  @override
  IconData getIcon() {

    if(sifre!=null){
      return EkleIcon.kilit;
    }

    return EkleIcon.liste;
  }

  @override
  void share(BuildContext context) {

    final RenderBox box = context.findRenderObject();

    String mailContent = "${this.baslik} \n\n";

    this.listCheckbox.forEach((cb) {
      mailContent += cb.isChecked ? "✔️" : "❌";
      mailContent += "\t ${cb.baslik} \n\n";
    });

    Share.share(
      mailContent,
      subject: this.baslik,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

}