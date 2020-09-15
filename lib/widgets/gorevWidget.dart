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

class GorevWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: Provider.of<Gorevler>(context, listen: false).length,
        itemBuilder: (BuildContext ctxt, int index){
        Icerik item = Provider.of<Gorevler>(context, listen: false).get(index);
          return Dismissible(
            key: ValueKey("item_$index"),
            direction: DismissDirection.horizontal,
            movementDuration: Duration(milliseconds: 300),
            onDismissed: (direction){
              print("sil");
              Provider.of<Gorevler>(context, listen: false).remove(item);
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
                )
            ),
          );
        }
    );
  }
}