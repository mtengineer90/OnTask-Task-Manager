import 'package:flutter/material.dart';
import 'package:ontask/models/liste.dart';
import 'dart:ffi';
import 'dart:math';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/klasor.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/gorevler.dart';
import 'package:ontask/widgets/gorevWidget.dart';
//import 'package:ontask/widgets/gorevWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnTask Görev Yöneticisi',
      theme: ThemeData(

        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'OnTask Görev Yöneticisi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;

  static List<Icerik> _icerik = List<Icerik>.generate(
      5, (index) => Gorev(
    "Başlık $index", false, false, null, "Açıklama $index",
    Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
  ));


  void _icerikEkle(String isim){
    setState(() {
      _counter++;
      Icerik item;
      switch(isim)
{
        case "Klasor":{
          item = Klasor(
            "Başlık $_counter", false, false, null, "Açıklama $_counter",
            Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
          );
          break;
        }
case "Gorev":{
  item = Gorev(
  "Başlık $_counter", false, false, null, "Açıklama $_counter",
      Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
  );
  break;
      }
      case "Liste":{
      item = Liste(
      "Başlık $_counter", false, false, null, "Açıklama $_counter",
      Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
      );
      break;
      }
    }
    _icerik.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => new Gorevler(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.title} $_counter"),
          ),
          body: Center(
            child: GorevWidget(_icerik),
          ),
          floatingActionButton: SpeedDial(
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
                onTap: ()=> _icerikEkle("Klasör"),
              ),
              SpeedDialChild(
                child: Icon(Icons.format_list_bulleted, color: Colors.white),
                label: "Liste Ekle",
                backgroundColor: Colors.pinkAccent,
                onTap: ()=> _icerikEkle("Liste"),
              ),
              SpeedDialChild(
                child: Icon(Icons.note, color: Colors.white),
                label: "Görev Ekle",
                backgroundColor: Colors.green,
                onTap: ()=> _icerikEkle("Görev"),
              ),
            ],
          ),
        ),
    );
  }
}
