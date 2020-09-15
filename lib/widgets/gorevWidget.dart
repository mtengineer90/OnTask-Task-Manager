import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/klasor.dart';
import 'package:ontask/models/kullanici.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/ogrenci.dart';

class GorevWidget extends StatelessWidget{

  List<Icerik> icerik;
  GorevWidget(this.icerik);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: icerik.length,
        itemBuilder: (BuildContext ctxt, int index){
          Icerik item = icerik[index];
          return ListTile(
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
          );
        }
    );
  }
}