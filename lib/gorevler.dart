import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:ontask/models/icerik.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/models/klasor.dart';

class Gorevler with ChangeNotifier{

  static int counter=0;

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
// Add type
//  void addContent(String name) {
//
//    /// Update the counter and refresh the vue
//    counter++;
//
//    // Factory
//    switch(name) {
//
//      case "Folder": {
//        notes.add(Folder(
//            "Folder title N°$counter",
//            false,
//            false,
//            null,
//            "description N°$counter",
//            Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
//        ));
//        break;
//      }
//
//      case "Note": {
//        notes.add(Note(
//            "Note title N°$counter",
//            false,
//            false,
//            null,
//            "description N°$counter",
//            Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
//        ));
//        break;
//      }
//
//      case "CheckList": {
//        notes.add(CheckList(
//            "CheckList title N°$counter",
//            false,
//            false,
//            null,
//            "description N°$counter",
//            Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
//        ));
//        break;
//      }
//    }
//
//    print(counter);
//    print(_notes);
//
//    notifyListeners();
//  }

