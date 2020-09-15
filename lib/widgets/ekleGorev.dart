import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/gorev.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

typedef IcerikCallback = void Function(Icerik item);

class EkleGorev extends StatefulWidget {

  final Gorev item;

  final IcerikCallback ekleItem;

  EkleGorev({this.ekleItem, this.item});

  @override
  EkleGorevState createState() => EkleGorevState();
}

class EkleGorevState extends State<EkleGorev> with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  //Gorev item = Gorev("",false,false,null,"",Colors.greenAccent);

  final baslikText = TextEditingController();
  final aciklamaText = TextEditingController();

  void fav() {
    setState(() {
      widget.item.favori = !widget.item.favori;
    });
  }

  void sil() {
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    baslikText.dispose();
    aciklamaText.dispose();
    super.dispose();
  }

  void renkDegistir(Color renk) {
    setState(() {
      widget.item.renk = renk;
    });
  }

  void kaydet() {

    print(baslikText.text);
    widget.item.baslik = baslikText.text;

    print(aciklamaText.text);
    widget.item.aciklama = aciklamaText.text;

    print("Renk: ");
    print(widget.item.renk.toString());

    widget.ekleItem(widget.item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: (widget.item.favori ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
            color: Colors.red[500],
            onPressed: () {
              this.fav();
            },
          ),

          IconButton(
            icon: (Icon(Icons.color_lens)),
            color: widget.item.renk != null ? widget.item.renk : Colors.white70,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Renk Seçiniz'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: widget.item.renk,
                        onColorChanged: (renk) {
                          renkDegistir(renk);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),

          IconButton(
            icon: (Icon(Icons.delete_outline, color: Colors.red)),
            onPressed: () {
              this.sil();
            },
          ),
          IconButton(
            icon: (Icon(Icons.check, color: Colors.green)),
            onPressed: () {
              this.kaydet();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            TextFormField(
              controller: baslikText,
              decoration: InputDecoration(
                  hintText: "Başlık"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Lütfen Başlık Giriniz...';
                }
                return null;
              },
            ),

            TextFormField(
              controller: aciklamaText,
              decoration: InputDecoration(
                  hintText: "İçerik"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Lütfen İçerik Giriniz...';
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                      this.kaydet();
                  }
                },
                child: Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}