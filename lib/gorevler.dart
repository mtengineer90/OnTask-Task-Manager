import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:ontask/models/icerik.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/gorev.dart';

class Gorevler with ChangeNotifier{
  static List<Icerik> _gorevler = List<Icerik>.generate(
    3, (index)=>Gorev(
    "Başlık $index", false, false, null, "Açıklama $index",
    Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
  )
  );

  get gorevler{
    return _gorevler;
  }

  get length{
    return _gorevler.length;
  }

  Icerik get(int index){
    return _gorevler[index];
  }

  void add(Icerik item){
    _gorevler.add(item);
    notifyListeners();
  }

  void remove(Icerik item){
    _gorevler.remove(item);
    notifyListeners();
  }
}