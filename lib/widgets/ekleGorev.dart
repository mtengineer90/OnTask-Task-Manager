import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:flutter/rendering.dart';

typedef IcerikCallback = void Function(Icerik item);

class EkleGorev extends StatefulWidget {
  final Gorev item;

  final IcerikCallback ekleItem;

  EkleGorev({this.ekleItem, this.item});

  @override
  EkleGorevState createState() => EkleGorevState();
}

class EkleGorevState extends State<EkleGorev>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final baslikText = TextEditingController();
  final aciklamaText = TextEditingController();

  final baslikTextTodoList = TextEditingController();
  final currentTextTodoList = TextEditingController();

  void fav() {
    setState(() {
      widget.item.favori = !widget.item.favori;
    });
  }

  void secure(String sifre) {
    setState(() {
      widget.item.secure(sifre);
    });
  }

  void unSecure() {
    setState(() {
      widget.item.unSecure();
    });
  }

  void sil() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void hatirlat() {
    print(widget.item.sonZaman);

    setState(() {
      /// Boş ise zamanı al
      if (widget.item.sonZaman == null) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: RenkPaleti.ACIK_KIRMIZI,
                      ),
                    ),
                    primaryColor: RenkPaleti.ACIK_KIRMIZI,
                    primaryContrastingColor: RenkPaleti.ACIK_KIRMIZI,
                    scaffoldBackgroundColor: RenkPaleti.ACIK_KIRMIZI,
                    barBackgroundColor: RenkPaleti.ACIK_KIRMIZI,
                    brightness: Brightness.light,
                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        widget.item.sonZaman = newDate;
                      });
                    },
                    initialDateTime: DateTime.now().add(Duration(minutes: 1)),
                    use24hFormat: true,
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(Duration(days: 365 * 30)),
                    minimumYear: DateTime.now().year,
                    maximumYear: DateTime.now().year + 20,
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    backgroundColor: CupertinoColors.white,
                  ),
                ),
              );
            });
      } else {
        widget.item.sonZaman = null;
      }
    });
  }

  void renkDegistir(Color renk) {
    setState(() {
      widget.item.renk = renk;
    });
  }

  void kaydet() {
    widget.item.baslik = baslikText.text;
    widget.item.aciklama = aciklamaText.text;
    widget.ekleItem(widget.item);

    widget.item.sonDegisimZamani = DateTime.now();

    if(widget.item.sonZaman != null) {
      widget.item.showNotification();
    }
    Navigator.pop(context);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    baslikText.dispose();
    aciklamaText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    baslikText.text = widget.item.baslik;
    aciklamaText.text = widget.item.aciklama;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: RenkPaleti.ACIK_KIRMIZI),
          onPressed: () => Navigator.of(context).pop(),
        ),

        actions: <Widget>[
          IconButton(
            icon: (FaIcon(FontAwesomeIcons.solidCircle)),
            color: widget.item.renk != null ? widget.item.renk : Colors.white70,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)
                      ),
                    ),
                    content: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        textDirection: TextDirection.ltr,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Renkler',
                            style: TextStyle(
                              fontSize: 30,
                              color: RenkPaleti.ACIK_KIRMIZI,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          /// RenkPalet
                          SingleChildScrollView(
                            padding: EdgeInsets.only(
                              top: 25, bottom:0,
                            ),
                            child: BlockPicker(
                              availableColors: RenkPaleti.LIST_RENKPALET,
                              pickerColor: widget.item.renk,
                              onColorChanged: (renk) {
                                renkDegistir(renk);
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          IconButton(
            icon: (widget.item.sonZaman != null ? Icon(Icons.alarm) : Icon(Icons.add_alarm)),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.hatirlat();
            },
          ),

          IconButton(
            icon: (widget.item.favori ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border)),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.fav();
            },
          ),

          IconButton(
            icon: (widget.item.sifre!=null ? Icon(EkleIcon.kilit) : Icon(EkleIcon.anahtar)),
            color: RenkPaleti.ACIK_KIRMIZI,
/*            onPressed: () {
              this.secure(sifre);
            },*/
          ),

          IconButton(
            icon: (Icon(Icons.delete_outline, color: RenkPaleti.ACIK_KIRMIZI,)),
            onPressed: () {
              this.sil();
            },
          ),

          IconButton(
            icon: (Icon(Icons.check,color: Colors.green,)),
            onPressed: () {
              this.kaydet();
            },
          ),

        ],
      ),
      body: gosterNot(),
    );
  }
  Form gosterNot(){
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 2,
                bottom: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
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
              child: TextFormField(
                controller: baslikText,
                decoration: InputDecoration(
                  hintText: "Başlık...",
                  hintStyle: TextStyle(
                    fontSize: 23,
                    color: Colors.pinkAccent[100],
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Başlık...';
                  }
                  return null;
                },
              ),
            ),

            Expanded(
              child:
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
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
                child: TextFormField(
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: aciklamaText,
                  decoration: InputDecoration(
                    hintText: "Açıklamalarınız...",
                    hintStyle: TextStyle(
                      fontSize: 23,
                      color: Colors.pinkAccent[100],
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Açıklamalarınız...';
                    }
                    return null;
                  },
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      // Check if valid
                      this.sil();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xfffb6c72), Color(0xffff988d)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'İptal',
                          style: TextStyle(
                            fontSize: 27,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      // Check if valid
                      if (_formKey.currentState.validate()) {
                        this.kaydet();
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff69d9cc), Color(0xff50ff8c)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Kaydet',
                          style: TextStyle(
                            fontSize: 27,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
