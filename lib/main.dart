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
import 'package:ontask/widgets/ekleGorev.dart';
import 'package:ontask/widgets/drawMenu.dart';
import 'package:ontask/widgets/flMenu.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'dart:ui' as ui;

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
        primarySwatch: RenkPaleti.BEYAZ,
        backgroundColor: Colors.white,
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

  Gorevler gorevler = Gorevler();

  void _ekleItem(Icerik item){
    setState(() {
      gorevler.add(item);
    });
  }

  int _seciliIndex = 0;

  void _seciliItem(int index){
    setState(() {
      _seciliIndex = index;

      switch(_seciliIndex){
        case 1:
          gosterEkleModel(context);
          break;
      }
    });
  }

  void _favIcerik(Icerik item){
    setState(() {
      item.favori = !item.favori;
    });
  }

  void _icerikSil(Icerik item){
    setState(() {
      gorevler.remove(item);
    });
  }

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
    gorevler.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => gorevler,
        child: Scaffold(
          drawer: DrawMenu(),
//          appBar: AppBar(
//            title: Text("${widget.title} $_counter"),
//          ),
          body: GorevWidget(
            silIcerik: (Icerik item){
              setState(() {
                _icerikSil(item);
              });
            },
            favIcerik: (Icerik item){
              setState(() {
                _favIcerik(item);
              });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        RenkPaleti.colorStart,
                        RenkPaleti.colorEnd,
                      ],
                    );
                  },
                  child: Icon(Icons.favorite_border),
                ),
                title: Container(),
              ),

              BottomNavigationBarItem(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        RenkPaleti.colorStart,
                        RenkPaleti.colorEnd,
                      ],
                    );
                  },
                  child: Icon(Icons.add_circle_outline),
                ),
                title: Container(),
              ),

              BottomNavigationBarItem(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        RenkPaleti.colorStart,
                        RenkPaleti.colorEnd,
                      ],
                    );
                  },
                  child: Icon(Icons.restore_from_trash),
                ),
                title: Container(),
              ),

            ],
            currentIndex: _seciliIndex,
            onTap: _seciliItem,
          ),
          floatingActionButton: FloatingMenu(
            ekleIcerik: (String isim) {
              setState(() {
                _icerikEkle(isim);
              });
            },
          ekleItem: (Icerik item){
              setState(() {
                _ekleItem(item);
              });
          }
          ),
        ),
    );
  }


void gosterEkleModel(context) {
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
              new ListTile(
                  leading: new Icon(Icons.note_add),
                  title: new Text('Görev'),
                  onTap: () => {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => EkleGorev(ekleItem: _ekleItem,))),
                  }
              ),

              new ListTile(
                leading: new Icon(Icons.playlist_add_check),
                title: new Text('Liste'),
                onTap: () => {
                  Navigator.pop(context),
                  _icerikEkle("Liste"),
                },
              ),

              new ListTile(
                leading: new Icon(Icons.create_new_folder),
                title: new Text('Klasör'),
                onTap: () => {
                  Navigator.pop(context),
                  _icerikEkle("Klasör"),
                },
              ),

            ],
          ),
        );
      }
  );
}}