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
import 'package:dotted_border/dotted_border.dart';

typedef IcerikSilCallback = void Function(Icerik item);
typedef ListeGosterCallback = void Function(BuildContext context, Icerik item);
typedef IcCallback = void Function(Gorevler gorevler);

class GorevWidget extends StatefulWidget {

  final Gorevler gorevler;
  final IcerikSilCallback silIcerik;
  final IcerikSilCallback favIcerik;
  final IcerikSilCallback ekleItem;
  final ListeGosterCallback gosterEkleListeModel;
  final IcCallback ic;
  final IcerikSilCallback sil;
  final IcerikSilCallback kurtar;

  GorevWidget({this.gorevler, this.silIcerik, this.favIcerik, this.ekleItem,
    this.gosterEkleListeModel, this.ic, this.sil, this.kurtar});

  @override
  GorevWidgetState createState() => GorevWidgetState();

}
class GorevWidgetState extends State<GorevWidget> with SingleTickerProviderStateMixin {

  bool _durum = false;

  toggleDropArea() {
    setState(() {
      this._durum = !this._durum;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _durumKey = GlobalKey<FormState>();
    Gorevler gorevler = Provider.of<Gorevler>(context, listen: false);
    return Column(
      children: <Widget>[

        Visibility(
          visible: _durum,
          child: DragTarget<Icerik>(
            key: _durumKey,
            onWillAccept: (data) => data is Icerik,
            onAccept: (data) {
              if(widget.gorevler.mode == Ayarlar.SILINEN){
                widget.kurtar(data);
              }
              else{
                widget.sil(data);
              }
            },
            onLeave: (data) {
              print("!!!");
            },
            builder: (context, candidateData, rejectedData) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 0,
                ),
                child: DottedBorder(
                  color: RenkPaleti.ACIK_KIRMIZI,
                  dashPattern: [8, 4],
                  strokeWidth: 2,
                  borderType: BorderType.Circle,
                  child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: Center(
                          child: Icon(
                            widget.gorevler.mode == Ayarlar.SILINEN ? Icons.restore_from_trash : Icons.delete,
                            color: RenkPaleti.ACIK_KIRMIZI,
                          ),
                        ),
                      )),
                ),
              );
            },
          ),
        ),

        Expanded(
          child: GridView.count(
            // Row width
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.only(
              top: 30,
            ),
            // Generate 100 widgets that display their index in the List.
            children: List.generate(widget.gorevler.contentLength, (index) {

              Icerik item = widget.gorevler.get(index);

              return Draggable<Icerik>(
                data: item,
                child: GestureDetector(
                  onTap: () {

                    if(item is Gorev) {

                      Navigator.push(context,MaterialPageRoute(builder: (context) => GosterGorev(
                        ekleItem: widget.ekleItem,
                        silItem: widget.silIcerik,
                        item: item,
                        favItem: widget.favIcerik,
                      )));
                    }

                    else if(item is Liste) {

                      widget.gosterEkleListeModel(
                          context,
                          item
                      );
                    }

                    else if(item is Klasor) {

                      widget.ic(item.icerik);
                    }
                  },
                  child: GridTile(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      elevation: 1.5,
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
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                item.getBaslik(),
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: RenkPaleti.ACIK_KIRMIZI,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1,1),
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
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                item.getAciklama(),
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                  color: RenkPaleti.ACIK_KIRMIZI,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1,1),
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
                ),
                feedback: GridTile(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 1.5,
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
                            color: item.getIconRenk(),
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
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              item.getBaslik(),
                              overflow: TextOverflow.ellipsis,
                              maxLines:2,
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RenkPaleti.ACIK_KIRMIZI,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1,1),
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
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              item.getAciklama(),
                              overflow: TextOverflow.ellipsis,
                              maxLines:2,
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: RenkPaleti.ACIK_KIRMIZI,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1,1),
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
                childWhenDragging: GridTile(
                  child: Card(
                    color:Colors.white70,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 0,
                    child: Column(
                      children: <Widget>[

                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          decoration: new BoxDecoration(
                              color: item.getRenk().withOpacity(0.5),
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
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              item.getBaslik(),
                              overflow: TextOverflow.ellipsis,
                              maxLines:2,
                              style: TextStyle(
                                backgroundColor: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RenkPaleti.ACIK_KIRMIZI,
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
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              item.getAciklama(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                backgroundColor: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: RenkPaleti.ACIK_KIRMIZI,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1,1),
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
                onDragStarted: () {

                  toggleDropArea();
                },
                onDragEnd: (details) {

                  toggleDropArea();
                },
                maxSimultaneousDrags: 1,
                  affinity: Axis.horizontal,
              );
            }),
          ),
        ),

      ],
    );
/*
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
                ic(item.icerik);
            }
          },
          child: GridTile(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 1.5,
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
                        item.getBaslik(),
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
*/
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