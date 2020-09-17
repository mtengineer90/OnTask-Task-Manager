import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/models/icerik.dart';
import 'dart:io';

class SifreEkran extends StatefulWidget {

  static const String SONUCOK = "TAMAM";
  static const String SONUCYANLIS = "HATA";

  final String sifre;

  SifreEkran({this.sifre});

  @override
  SifreEkranState createState() => SifreEkranState();
}

class SifreEkranState extends State<SifreEkran> with SingleTickerProviderStateMixin {

  String guncelSifre = "";

  Container anahtarBtn(Widget child) {

    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 60,
      child: child,
    );
  }

  Widget validationDot(int min) {

    Color renk = Colors.black12;
    if(guncelSifre.length >= min) {

      if(guncelSifre.length == widget.sifre.length) {

        if(guncelSifre == widget.sifre) {

          renk = RenkPaleti.colorEnd;

          Navigator.pop(context,SifreEkran.SONUCOK);
        }
        else {
          renk = Colors.redAccent;
        }

      } else {
        renk = RenkPaleti.colorStart;
      }
    }

    return Icon(
      FontAwesomeIcons.solidCircle,
      size: 15,
      color: renk,
    );
  }

  Container anahtarBtnDigit(String digit) {
    return anahtarBtn(
      FlatButton(
        onPressed: () {

          if(this.guncelSifre.length < 4) {
            setState(() {
              this.guncelSifre += digit;
            });
          }

        },
        child: Text(
          digit,
          style: TextStyle(
            color: RenkPaleti.ACIK_KIRMIZI,
            fontSize: 50,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {

    if(widget.sifre == null || widget.sifre == "") {
      print(widget.sifre);
      Navigator.pop(context,SifreEkran.SONUCOK);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double spaceRow = 40;
    return Scaffold(
      body: Container(
//        color: Colors.yellow,
        margin: const EdgeInsets.only(
          top: 75,
          bottom: 40,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
//              color: Colors.red,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Icon(
                      guncelSifre == widget.sifre ? EkleIcon.anahtar : EkleIcon.kilit,
                      color: RenkPaleti.ACIK_KIRMIZI,
                      size: 60,
                    ),
                  ),

                  Text(
                    "Giriş Yapınız...",
                    style: TextStyle(
                      color: RenkPaleti.ACIK_KIRMIZI,
                      fontSize: 25,
                    ),
                  ),

                ],
              ),
            ),

            Container(
//              color: Colors.greenAccent,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  validationDot(1),
                  validationDot(2),
                  validationDot(3),
                  validationDot(4),
                ],
              ),
            ),

            Container(
//              color: Colors.black12,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: spaceRow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        anahtarBtnDigit("1"),
                        anahtarBtnDigit("2"),
                        anahtarBtnDigit("3"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: spaceRow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        anahtarBtnDigit("4"),
                        anahtarBtnDigit("5"),
                        anahtarBtnDigit("6"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: spaceRow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        anahtarBtnDigit("7"),
                        anahtarBtnDigit("8"),
                        anahtarBtnDigit("9"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      anahtarBtn(
                          IconButton(
                            icon: Icon(
                              Icons.fingerprint,
                              size: 45,
                              color: RenkPaleti.ACIK_KIRMIZI,
                            ),
                            onPressed: () {
                              gosterParmakiziModel(context);
                            },
                          )
                      ),
                      anahtarBtnDigit("0"),
                      anahtarBtn(
                        IconButton(
                          onPressed: () {
                            if(guncelSifre != null && guncelSifre != "") {
                              setState(() {
                                guncelSifre = guncelSifre.substring(0, guncelSifre.length - 1);
                              });
                              print(guncelSifre);
                            }
                          },
                          icon: Icon(
                            Icons.backspace,
                            size: 35,
                            color: RenkPaleti.ACIK_KIRMIZI,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  void gosterParmakiziModel(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 8,
                    width: 80,
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      color: RenkPaleti.ACIK_KIRMIZI,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: Text(
                          "Kayıt için Tıklayınız",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: RenkPaleti.ACIK_KIRMIZI,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.fingerprint,
                          size: 70,
                          color: RenkPaleti.ACIK_KIRMIZI,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          );
        }
    );
  }

}