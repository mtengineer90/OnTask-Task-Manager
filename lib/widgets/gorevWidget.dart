import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/models/checkbox.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/klasor.dart';
import 'package:ontask/models/kullanici.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/ogrenci.dart';
import 'package:ontask/widgets/ekleGorev.dart';
import 'package:provider/provider.dart';
import 'package:ontask/gorevler.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:ontask/widgets/gosterGorev.dart';

typedef IcerikSilCallback = void Function(Icerik item);
typedef ListeGosterCallback = void Function(BuildContext context, Icerik item);

class GorevWidget extends StatelessWidget {

  final IcerikSilCallback silIcerik;
  final IcerikSilCallback favIcerik;
  final IcerikSilCallback ekleItem;
  final ListeGosterCallback gosterEkleListeModel;

  GorevWidget({this.silIcerik, this.favIcerik, this.ekleItem,
    this.gosterEkleListeModel});

  @override
  Widget build(BuildContext context) {
    Gorevler gorevler = Provider.of<Gorevler>(context, listen: false);

    return GridView.count(
      // Row width
      crossAxisCount: 2,
      childAspectRatio: 1,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(gorevler.length, (index) {
        Icerik item = gorevler.get(index);
        return GestureDetector(
          onTap: () {
            if (item is Gorev) {

              ///Goreve git
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  GosterGorev(
                    ekleItem: ekleItem,
                    silItem: silIcerik,
                    item: item,
                    favItem: favIcerik,
                  )));
            }

            /// Listeye git
            else if (item is Liste) {
              gosterEkleListeModel(
                  context,
                  item
              );
            }

            /// Klasöre git
            else if (item is Klasor) {

            }
          },
          child: GridTile(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    decoration: new BoxDecoration(
                        color: item.getRenk(),
                        borderRadius: new BorderRadius.all(Radius.circular(50))
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      item.getIcon(),
                      color: Colors.white,
                      size: 25,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 5,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.baslik,
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: RenkPaleti.ACIK_KIRMIZI,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              color: Color.fromARGB(50, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.getAciklama(),
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: RenkPaleti.ACIK_KIRMIZI,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              color: Color.fromARGB(50, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );

    /* Widget build(BuildContext context) {
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
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                      bottom: Radius.circular(25.0),),
                          ),
                        IcerikPadding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 20,
                          bottom: 25,
                        ),
                        title: Text(
                          "Emin misiniz ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: RenkPaleti.ACIK_KIRMIZI,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                        Icerik: Image.asset(
                          'assets/bos.png',
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.noRepeat,
                          scale: 1,
                        ),
                        actions: <Widget>[

                        ],
                      );
                    });
                return res;
              } else {

                if(item is Gorev) {
                  // Go edit activity
                  Navigator.push(context,MaterialPageRoute(builder: (context) => EkleGorev(
                    ekleItem: ekleItem,
                    item: item,
                  )));
                }
                // Edit Klasör
                else if(item is Klasor) {
                  print("Klasör");
                }
                // Edit Liste
                else if(item is Liste) {
                  print("Liste");
                }
              }
            },
            child: ListTile(
                title: Text(
                    item.baslik,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize:20,
                    )
                ),
                subtitle: Text(item.aciklama,
                overflow: TextOverflow.ellipsis,),
                leading: Icon(
                  item.icon, color:item.renk,
                ),
              trailing: IconButton(
                icon: (item.favori ? Icon(Icons.bookmark,
                    color: RenkPaleti.ACIK_KIRMIZI)
                    : Icon(Icons.bookmark_border)),
                color: Colors.red[500],
                onPressed: (){
                  this.favIcerik(item);
                },
              ),
              onTap: (){
                if(item is Gorev) {

                  Navigator.push(context,MaterialPageRoute(builder: (context) => GosterGorev(
                    ekleItem: ekleItem,
                    silItem: silIcerik;
                    item: item,
                  )));
                }

                else if(item is Liste) {

                }

                else if(item is Klasor) {

                }
              },
            ),
          );
        }
    );
  }*/
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
}