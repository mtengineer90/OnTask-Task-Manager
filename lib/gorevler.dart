import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:ontask/models/icerik.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/klasor.dart';
import 'package:ontask/ayarlar/sabitler.dart';

class Gorevler with ChangeNotifier{

  static int counter=0;

Gorevler parent;

List<Icerik> _gorevler = List<Icerik>();

  String mode = Ayarlar.NORMAL;

  get content {

    if(mode == Ayarlar.FAVORI) {
      return this.favoriler;
    }
    else if(mode == Ayarlar.SILINEN) {
      return this.gorevlerSilinmis;
    }
    else {
      return this.gorevler;
    }
  }

  get contentLength {

    if(mode == Ayarlar.FAVORI) {
      return this.lengthFav;
    }
    else if(mode == Ayarlar.SILINEN) {
      return this.lengthSilinmis;
    }
    else {
      return this.length;
    }
  }

  Icerik get(int index) {

    if(mode == Ayarlar.FAVORI) {
      return this.favoriler[index];
    }
    else if(mode == Ayarlar.SILINEN) {
      return this.gorevlerSilinmis[index];
    }
    else {
      return this.gorevler[index];
    }
  }



  get gorevler{
    return _gorevler.where((e) => e.silindiMi == false).toList();
  }

  get favoriler{
    return _gorevler.where((e) => (e.favori == true)&&(e.silindiMi==false)).toList();
  }

  get gorevlerSilinmis{
    return _gorevler.where((e) => e.silindiMi == true).toList();
  }

  get length{
    return gorevler.length;
  }

  get lengthFav{
    return favoriler.length;
  }

  get lengthSilinmis{
    return gorevlerSilinmis.length;
  }

  Icerik getSilinmis(int index){
    return gorevlerSilinmis[index];
  }

  void add(Icerik item){

    Icerik varMi;

    if(_gorevler != null && _gorevler.length > 0) {

      _gorevler.forEach((element) {
        if(element.id == item.id) {
          varMi = element;
        }
      });
    }
    if(varMi!=null){
      varMi=item;
    }
    else {
      if(item is Klasor){
        item.icerik.parent = this;
        print("item.icerik.parent ");
        print(item.icerik.parent );
      }
      _gorevler.add(item);
    }
    notifyListeners();
  }

  void remove(Icerik item){
    gorevler.remove(item);
    item.silindiMi = true;
    notifyListeners();
  }

  void kurtar(Icerik item){
    item.silindiMi=false;
    notifyListeners();
  }

  void goster(){

     _gorevler = List<Icerik>.generate(
        30, (index)=>Gorev(
      "Mobil Uygulama Geliştirme $index", false, false, null,
      "Mobil uygulama geliştirme, kişisel dijital yardımcılar, kurumsal dijital yardımcılar veya cep telefonları gibi mobil cihazlar için bir mobil uygulamanın geliştirildiği eylem veya süreçtir.",
      //Colors.primaries[new Random().nextInt(Colors.primaries.length-1)],
      null,
    )
    );
  }
}

