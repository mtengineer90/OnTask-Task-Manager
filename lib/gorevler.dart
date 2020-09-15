import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:ontask/models/icerik.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/gorev.dart';

class Gorevler with ChangeNotifier{

  static int counter=0;

  static List<Icerik> _gorevler = List<Icerik>.generate(
    3, (index)=>Gorev(
    "Başlık $index", false, false, null, "Açıklama $index",
    Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
  )
  );

  get gorevler{
    return _gorevler.where((e) => e.silindiMi == false).toList();
  }

  get favoriler{
    return _gorevler.where((e) => e.favori == true).toList();
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

  Icerik get(int index){
    return gorevler[index];
  }

  Icerik getSilinmis(int index){
    return gorevlerSilinmis[index];
  }

  void add(Icerik item){
    _gorevler.add(item);
    notifyListeners();
  }

  void remove(Icerik item){
    gorevler.remove(item);
    item.silindiMi = true;
    notifyListeners();
  }
}

