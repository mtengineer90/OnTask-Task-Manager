import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/gorevler.dart';
import 'package:flutter/cupertino.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/models/gorev.dart';


class Klasor extends Icerik with ChangeNotifier{
  static int counter = 0;
  Klasor parent;
  List<Icerik> _gorevler = List<Icerik>();
  String mode = Ayarlar.NORMAL;
  Klasor.empty(): super("", false, false, "", "", null);

  Klasor(baslik, favori, secured, sifre, aciklama, renk):
      super(baslik, favori, secured, sifre, aciklama, renk);

  @override
  String getAciklama() {
    if(sifre!=null){
      return "Kilitli Klasör";
    }

    return "${this.gorevler.length} İçeriği";
  }

  @override
  IconData getIcon() {
    if(sifre!=true){
      return EkleIcon.kilit;
    }

    if(icerik.length > 1) {
      return EkleIcon.klasor;
    }
    else {
      return EkleIcon.klasor;
    }
  }

  List<Icerik> getContentFiltered(String filter) {

    List<Icerik> res;

    if(mode == Ayarlar.FAVORI) {
      res = this.favoriler;
    }
    else if(mode == Ayarlar.SILINEN) {
      res = this.silinenler;
    }
    else {
      res = this.gorevler;
    }

    res = res.where((element) => element.baslik.toLowerCase().contains(filter.toLowerCase())).toList();

    return res.length <= 0 ? this.icerik : res.toList();
  }

  int contentLengthFiltered(String filter) {
    return filter == null || filter == "" ? this.icerikLength : this.getContentFiltered(filter).length;
  }

  Icerik getFiltered(String filter, int index) {
    return filter == null || filter == "" ? this.icerik[index] : this.getContentFiltered(filter)[index];
  }

  get icerik {

    if(mode == Ayarlar.FAVORI) {
      return this.favoriler;
    }
    else if(mode == Ayarlar.SILINEN) {
      return this.silinenler;
    }
    else {
      return this.gorevler;
    }
  }

  get icerikLength {

    if(mode == Ayarlar.FAVORI) {
      return this.favoriLength;
    }
    else if(mode == Ayarlar.SILINEN) {
      return this.silinenlerLength;
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
      return this.silinenler[index];
    }
    else {
      return this.gorevler[index];
    }
  }

  void sortByLastEdit() {
    _gorevler.sort((b, a) => a.sonDegisimZamani.compareTo(b.sonDegisimZamani));
  }

  get gorevler {
    sortByLastEdit();
    return _gorevler.where((e) => e.silindiMi == false).toList();
  }

  get favoriler {
    sortByLastEdit();
    return _gorevler.where((e) => (e.favori == true) && (e.silindiMi == false)).toList();
  }

  get silinenler {
    sortByLastEdit();
    return _gorevler.where((e) => e.silindiMi == true).toList();
  }

  get length {
    return gorevler.length;
  }

  get favoriLength {
    return favoriler.length;
  }

  get silinenlerLength {
    return silinenler.length;
  }

  Icerik getSilinenler(int index) {
    return silinenler[index];
  }

  void add(Icerik item) {

    Icerik varMi;

    if(_gorevler != null && _gorevler.length > 0) {

      _gorevler.forEach((element) {
        if(element.id == item.id) {
          varMi = element;
        }
      });
    }

    if(varMi != null) {
      varMi = item;

    } else {

      if(item is Klasor) {
        item.parent = this;
        print(item.parent);
      }

      _gorevler.add(item);
    }

    notifyListeners();
  }

  void remove(Icerik item) {
    item.silindiMi = true;
    notifyListeners();
  }

  void erase(Icerik item) {
    _gorevler.remove(item);
    notifyListeners();
  }

  void restore(Icerik item) {
    item.silindiMi = false;
    notifyListeners();
  }

  void goster() {

    Klasor klasor1 = Klasor(
      "YKS ${DateTime.now().year + 1} Çalışma Görevleri",
      false,
      false,
      null,
      "",
      Color(0xFFF1B9A3),
    );

    this.add(klasor1);

    Liste liste1 = Liste(
      "Konu Anlatımları",
      false,
      false,
      null,
      "",
      Color(0xFFFFD18B),
    );

    liste1.listCheckbox.add(CheckBox("Türkçe",false));
    liste1.listCheckbox.add(CheckBox("Edebiyat",false));
    liste1.listCheckbox.add(CheckBox("Matematik",true));
    liste1.listCheckbox.add(CheckBox("Geometri",false));
    liste1.listCheckbox.add(CheckBox("Fizik",true));
    liste1.listCheckbox.add(CheckBox("Kimya",true));
    liste1.listCheckbox.add(CheckBox("Biyoloji",false));
    liste1.listCheckbox.add(CheckBox("Tarih",false));
    liste1.listCheckbox.add(CheckBox("Coğrafya",true));
    liste1.listCheckbox.add(CheckBox("Vatandaşlık",true));
    liste1.listCheckbox.add(CheckBox("Din Kültürü",false));

    klasor1.add(liste1);

    this.add(
        Gorev(
          "Tarih",
          false,
          false,
          null,
          "İslamiyet Öncesi Türk Devletleri\n" +
              "İlk İslam - Türk Devletleri\n" +
              "Türkiye Tarihi\n" +
              "Osmanlı Kuruluş Dönemi\n" +
              "Kurtuluş Savaşı\n" +
                  "II. Dünya Savaşı ve Sonrası",
          Color(0xFFFDEABF),
        )
    );

    Liste liste2 = Liste(
      "Tarih Deneme Sınavları",
      false,
      false,
      null,
      "",
      Color(0xFFFFD18B),
    );

    liste2.listCheckbox.add(CheckBox("Deneme 1",true));
    liste2.listCheckbox.add(CheckBox("Deneme 2",true));
    liste2.listCheckbox.add(CheckBox("Deneme 3",true));
    liste2.listCheckbox.add(CheckBox("Deneme 4",true));
    liste2.listCheckbox.add(CheckBox("Deneme 5",true));
    liste2.listCheckbox.add(CheckBox("Deneme 6",true));
    liste2.listCheckbox.add(CheckBox("Deneme 7",true));


    this.add(liste2);

  }
}