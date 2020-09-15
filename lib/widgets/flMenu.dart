import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ontask/widgets/ekleGorev.dart';
import 'package:ontask/models/icerik.dart';

typedef IcerikEkleIcerikCallback = void Function(String isim);
typedef IcerikEkleItemCallback = void Function(Icerik item);

class FloatingMenu extends StatelessWidget {

  final IcerikEkleIcerikCallback ekleIcerik;
  final IcerikEkleItemCallback ekleItem;

  FloatingMenu({this.ekleIcerik, this.ekleItem});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.white,
      overlayOpacity: 0.60,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: CircleBorder(),
      children: [

        SpeedDialChild(
            child: Icon(Icons.folder, color: Colors.white),
            label: "Klasör Ekle",
            backgroundColor: Colors.pink,
            onTap: () => ekleIcerik("Klasör")),

        SpeedDialChild(
            child: Icon(Icons.format_list_bulleted, color: Colors.white),
            label: "Liste Ekle",
            backgroundColor: Colors.pinkAccent,
            onTap: () => ekleIcerik("Liste")),

        SpeedDialChild(
            child: Icon(Icons.note, color: Colors.white),
            label: "Görev Ekle",
            backgroundColor: Colors.green,
            onTap: () {
//              main.addContent("Note");
              Navigator.push(context,MaterialPageRoute(builder: (context) => EkleGorev(ekleItem: ekleItem)));
            }),
      ],
    );
  }
}