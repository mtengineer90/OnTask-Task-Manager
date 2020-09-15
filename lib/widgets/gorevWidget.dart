import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/klasor.dart';
import 'package:ontask/models/kullanici.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/ogrenci.dart';
import 'package:provider/provider.dart';
import 'package:ontask/gorevler.dart';

typedef IcerikSilCallback = void Function(Icerik item);

class GorevWidget extends StatelessWidget{

  final IcerikSilCallback silIcerik;
  final IcerikSilCallback favIcerik;
  
  GorevWidget({this.silIcerik, this.favIcerik});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Provider.of<Gorevler>(context, listen: false).length,
        itemBuilder: (BuildContext ctxt, int index){
          Gorevler gorevler = Provider.of<Gorevler>(context, listen: false);
          Icerik item = gorevler.get(index);
          return Dismissible(
            key: ValueKey("item_$index"),
            direction: DismissDirection.horizontal,
            movementDuration: Duration(milliseconds: 300),
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            // ignore: missing_return
            confirmDismiss: (direction) async {

              if (direction == DismissDirection.endToStart) {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "${item.baslik} - Silmek istediğinizden emin misiniz?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "İptal",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Sil",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              silIcerik(item);
                              //Provider.of<Gorevler>(context, listen: false).remove(item);
//                              Scaffold
//                                  .of(context)
//                                  .showSnackBar(SnackBar(content: Text("${item.baslik} arşivlendi!")));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                return res;
              } else {
              }
            },
            child: ListTile(
                title: Text(
                    item.baslik,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize:20,
                    )
                ),
                subtitle: Text(item.aciklama),
                leading: Icon(
                  item.icon, color:item.renk,
                ),
              trailing: IconButton(
                icon: (item.favori ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
                color: Colors.red[500],
                onPressed: (){
                  this.favIcerik(item);
                },
              ),
            ),
          );
        }
    );
  }
}
Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Düzenle",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.archive,
            color: Colors.white,
          ),
          Text(
            " Arşivle",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}