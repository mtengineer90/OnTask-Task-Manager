import 'package:flutter/cupertino.dart';
import 'package:ontask/models/icerik.dart';

class Gorevler with ChangeNotifier{
  List<Icerik> _gorevler = new List();

  get gorevler{
    return _gorevler;
  }

  set gorevler(Icerik item){
    _gorevler.add(item);
    notifyListeners();
  }
}