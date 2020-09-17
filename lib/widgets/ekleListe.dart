import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/gorev.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef IcerikCallBack = void Function(Icerik item);

class EkleListe extends StatefulWidget {

  final Liste item;

  final IcerikCallBack ekleItem;
  final IcerikCallBack silItem;

  EkleListe({this.ekleItem, this.item, this.silItem});

  @override
  EkleListeState createState() => EkleListeState();
}

class EkleListeState extends State<EkleListe> with SingleTickerProviderStateMixin {

  final _formKeyTodoList = GlobalKey<FormState>();

  // Controllers
  final baslikText = TextEditingController();
  final aciklamaText = TextEditingController();

  final baslikTextTodoList = TextEditingController();
  final currentTextTodoList = TextEditingController();

  final _formKeyTodoListInsertion = GlobalKey<FormState>();

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

  void yoket() {
    setState(() {
      widget.silItem(widget.item);
      Navigator.pop(context);
    });
  }

  void degistirRenk(Color renk) {
    setState(() {
      widget.item.renk = renk;
    });
  }

  void kaydet() {

    Liste todoList = widget.item;

    // Check if valid
    if (_formKeyTodoList.currentState.validate()) {
      setState(() {
        todoList.baslik = baslikTextTodoList.text;
        widget.ekleItem(todoList);
      });

      Navigator.pop(context);
    }
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
                      vertical: 15,
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
                          SingleChildScrollView(
                            padding: EdgeInsets.only(
                              top: 25,
                              bottom: 0,
                            ),
                            child: BlockPicker(
                              availableColors: RenkPaleti.LIST_RENKPALET,
                              pickerColor: widget.item.renk,
                              onColorChanged: (renk) {
                                degistirRenk(renk);
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
            icon: (widget.item.favori ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border)),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.fav();
            },
          ),

          IconButton(
            icon: Icon(EkleIcon.ucak, color: RenkPaleti.ACIK_KIRMIZI,),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              widget.item.share(context);
            },
          ),

          IconButton(
            icon: (widget.item.sifre != null ? Icon(EkleIcon.kilit) : Icon(EkleIcon.anahtar)),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.secure("1111");
            },
          ),

          IconButton(
            icon: (Icon(Icons.delete_outline, color: RenkPaleti.ACIK_KIRMIZI,)),
            onPressed: () {
              this.yoket();
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
      body: showListOn(),
    );
  }

  Form showListOn() {

    Liste todoList = widget.item;

    baslikTextTodoList.text = todoList.baslik;

    return Form(
      key: _formKeyTodoList,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
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
              style: TextStyle(
                color: RenkPaleti.ACIK_KIRMIZI,
              ),
              decoration: InputDecoration(
                hintText: "Başlık...",
                hintStyle: TextStyle(
                  fontSize: 23,
                  color: RenkPaleti.ACIK_KIRMIZI.withOpacity(0.50),
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

          StatefulBuilder(
            builder: (context, setState) {
              return Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: todoList.listCheckbox.length, // How many elements
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Theme(
                              data: ThemeData(
                                primaryColor: RenkPaleti.ACIK_KIRMIZI,
                                unselectedWidgetColor: RenkPaleti.ACIK_KIRMIZI,
                                backgroundColor: Colors.white,
                              ),
                              child: Dismissible(
                                key: Key(todoList.listCheckbox[index].toString() + index.toString()),
                                onDismissed: (direction) {
                                  // Delete the CheckBox
                                  setState(() {
                                    todoList.listCheckbox.removeAt(index);
                                  });

                                  // Show a SnackBar
                                  Scaffold
                                      .of(context)
                                      .showSnackBar(SnackBar(content: Text("Silindi!")));

                                },
                                child: CheckboxListTile(
                                  title: SelectableText(
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
                              ),
                            );
                          }
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
                            Expanded(
                              child: TextFormField(
                                controller: currentTextTodoList,
                                style: TextStyle(
                                  color: RenkPaleti.ACIK_KIRMIZI,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Ekleyiniz...",
                                  hintStyle: TextStyle(
                                    fontSize: 23,
                                    color: RenkPaleti.ACIK_KIRMIZI.withOpacity(0.50),
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ekleyiniz...';
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
                                    todoList.listCheckbox.add(CheckBox(
                                      currentTextTodoList.text,
                                      false,
                                    ));
                                  });
                                  currentTextTodoList.clear();
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

                  ],
                ),
              );
            },
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
                    kaydet();
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
    );
  }
}