import 'package:flutter/material.dart';
import 'package:ontask/models/liste.dart';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/rendering.dart';
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
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontask/models/checkbox.dart';

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  Gorevler gorevler = Gorevler();

  void _ekleItem(Icerik item) {
    setState(() {
      gorevler.add(item);
    });
  }

  int _seciliIndex = 0;

  void _seciliItem(int index) {
    setState(() {
      _seciliIndex = index;

      switch (_seciliIndex) {
        case 1:
          gosterEkleModel(context);
          break;
      }
    });
  }

  void _favIcerik(Icerik item) {
    setState(() {
      item.favori = !item.favori;
    });
  }

  void _icerikSil(Icerik item) {
    setState(() {
      gorevler.remove(item);
    });
  }

  void _icerikEkle(String isim) {
    setState(() {
      _counter++;
      Icerik item;

      switch (isim) {
        case "Klasor":
          {
            item = Klasor(
                "Başlık $_counter",
                false,
                false,
                null,
                "Açıklama $_counter",
                Colors.primaries[
                    new Random().nextInt(Colors.primaries.length - 1)]);
            break;
          }
        case "Gorev":
          {
            item = Gorev(
                "Başlık $_counter",
                false,
                false,
                null,
                "Açıklama $_counter",
                Colors.primaries[
                    new Random().nextInt(Colors.primaries.length - 1)],
                null);
            break;
          }
        case "Liste":
          {
            item = Liste(
                "Başlık $_counter",
                false,
                false,
                null,
                "Açıklama $_counter",
                Colors.primaries[
                    new Random().nextInt(Colors.primaries.length - 1)]);
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
//          drawer: DrawMenu(),
        backgroundColor: Color(0xFFFEEBDF),
        body: Container(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: GorevWidget(
            ekleItem: (Icerik item) {
              setState(() {
                _ekleItem(item);
              });
            },
            silIcerik: (Icerik item) {
              setState(() {
                _icerikSil(item);
              });
            },
            favIcerik: (Icerik item) {
              setState(() {
                _favIcerik(item);
              });
            },
            gosterEkleListeModel: (context,Icerik item) {
              setState(() {
                gosterEkleListeModel(context,item);
              });
            },
          ),
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
        floatingActionButton: FloatingMenu(ekleIcerik: (String isim) {
          setState(() {
            _icerikEkle(isim);
          });
        }, ekleItem: (Icerik item) {
          setState(() {
            _ekleItem(item);
          });
        }),
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
        builder: (BuildContext bc) {
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
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
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
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: new Icon(
                      EkleIcon.klasor,
                      color: RenkPaleti.ACIK_KIRMIZI,
                      size: 30,
                    ),
                    title: new Text(
                      'Yeni Klasör',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFE15A61),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 7,
                      bottom: 7,
                    ),
                    subtitle: new Text(
                      'Görevlerinizi saklayabileceğiniz Klasör ekleyin...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFFF8C8E),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pop(context),
                      gosterEkleKlasorModel(context),
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 20,
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
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: new Icon(
                      EkleIcon.gorev,
                      color: RenkPaleti.ACIK_KIRMIZI,
                      size: 30,
                    ),
                    title: Text(
                      'Yeni Görev Alanı...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFE15A61),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 7,
                      bottom: 7,
                    ),
                    subtitle: new Text(
                      'Kolayca Görev Ekleyin...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFFF8C8E),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EkleGorev(
                                    ekleItem: _ekleItem,
                                    item: Gorev("", false, false, null, "",
                                        Colors.greenAccent, null),
                                  ))),
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 20,
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
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: new Icon(
                      EkleIcon.liste,
                      color: RenkPaleti.ACIK_KIRMIZI,
                      size: 30,
                    ),
                    title: new Text(
                      'Yeni Görev Listesi',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFE15A61),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 7,
                      bottom: 7,
                    ),
                    subtitle: new Text(
                      'Yeni Görev Listesi Oluşturun...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFFF8C8E),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pop(context),
                      gosterEkleListeModel(
                        context,
                        Liste(
                          "",false,false,null,
                          "",Colors.primaries[new Random().nextInt(Colors.primaries.length-1)]
                        )
                      )
                    },
                  ),
                ),
              ],
            ),
          );
        }
        );
  }

  void gosterEkleKlasorModel(context) {

    final _formKey = GlobalKey<FormState>();

    final baslikText = TextEditingController();

    Klasor klasor = Klasor(
        null,
        false,
        false,
        null,
        "Açıklama mevcut değil...",
        Colors.primaries[Random().nextInt(Colors.primaries.length-1)]
    );

    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc){
          return Form(
            key: _formKey,
            child: new Wrap(
              spacing: 20,
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
                      color:RenkPaleti.ACIK_KIRMIZI,
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
                  height: 55,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 2,
                    ),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: BlockPicker(
                      layoutBuilder: (context, colors, child) {
                        Orientation orientation = MediaQuery.of(context).orientation;
                        return Container(
                          width: orientation == Orientation.portrait ? 340.0 : 300.0,
                          height: orientation == Orientation.portrait ? 360.0 : 200.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: colors.map((Color color) => child(color)).toList(),
                          ),
                        );
                      },
                      availableColors: RenkPaleti.LIST_RENKPALET,
                      pickerColor: klasor.renk,
                      onColorChanged: (renk) {
                        setState(() {
                          klasor.renk = renk;
                        });
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 10,
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
                    controller: baslikText,
                    decoration: InputDecoration(
                      hintText: "Klasör Adı...",
                      hintStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.pinkAccent[100],
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Klasör Adı...';
                      }
                      return null;
                    },
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
                          Navigator.pop(context);
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

                            print(baslikText.text);

                            klasor.baslik = baslikText.text;

                            _ekleItem(klasor);

                            Navigator.pop(context);
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
                              'Oluştur',
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
          );
        }
    );
  }

  void gosterEkleListeModel(context, Liste todoList) {

    // Check empty
    if(todoList == null) return;

    final _formKeyTodoList = GlobalKey<FormState>();
    final _formKeyTodoListInsertion = GlobalKey<FormState>();

    final baslikTextTodoList = TextEditingController();
    final elemanTextTodoList = TextEditingController();

    baslikTextTodoList.text = todoList.baslik;

    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc){
          return Form(
            key: _formKeyTodoList,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
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
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 10,
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
                    controller: baslikTextTodoList,
                    decoration: InputDecoration(
                      hintText: "Klasör Adı...",
                      hintStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.pinkAccent[100],
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Klasör Adı...';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return ListView.builder(
                          itemCount: todoList.listCheckbox.length, // How many elements
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Theme(
                              data: ThemeData(
                                primaryColor: RenkPaleti.ACIK_KIRMIZI,
                                unselectedWidgetColor: RenkPaleti.ACIK_KIRMIZI,
                                backgroundColor: Colors.white,
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  todoList.listCheckbox[index].baslik.substring(0,1).toUpperCase() + todoList.listCheckbox[index].baslik.substring(1),
                                  style: TextStyle(
                                    color: Color(0xFFFF8C8E),
                                    fontSize: 20,
                                  ),
                                ),
                                value: todoList.listCheckbox[index].isChecked,
                                controlAffinity: ListTileControlAffinity.leading,
                                checkColor: Colors.white,
                                activeColor: RenkPaleti.ACIK_KIRMIZI,
                                onChanged: (bool value) {
                                  setState(() {
                                    todoList.listCheckbox[index].isChecked = value;
                                  });
                                },
                              ),
                            );
                          }
                      );
                    },
                  ),
                ),

                Form(
                  key: _formKeyTodoListInsertion,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 10,
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
                    child: Row(
                      children: <Widget>[

                        Flexible(
                          child: TextFormField(
                            controller: elemanTextTodoList,
                            decoration: InputDecoration(
                              hintText: "İçerik Ekleyin...",
                              hintStyle: TextStyle(
                                fontSize: 23,
                                color: Colors.pinkAccent[100],
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'İçerik Ekleyin...';
                              }
                              return null;
                            },
                          ),
                        ),

                        IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            if (_formKeyTodoListInsertion.currentState.validate()) {
                              setState(() {
                                // Add Checkbox
                                todoList.listCheckbox.add(CheckBox(
                                  elemanTextTodoList.text,
                                  false,
                                ));

                              });
                              print(elemanTextTodoList.text);
                              print(todoList.listCheckbox);
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30,
                            color: RenkPaleti.ACIK_KIRMIZI,
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                      ],
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
                          Navigator.pop(context);
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
                          if (_formKeyTodoList.currentState.validate()) {
                            print(baslikTextTodoList.text);
                            setState(() {
                              todoList.baslik = baslikTextTodoList.text;
                              _ekleItem(todoList);
                            });

                            Navigator.pop(context);
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
                              'Oluştur',
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
          );
        }
    );
  }
}
