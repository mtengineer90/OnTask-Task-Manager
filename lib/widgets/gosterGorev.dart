import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ontask/models/icerik.dart';
import 'package:ontask/models/gorev.dart';
import 'package:ontask/models/liste.dart';
import 'package:ontask/widgets/ekleGorev.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:intl/intl.dart';

typedef IcerikCallback = void Function(Icerik item);

class GosterGorev extends StatefulWidget {

  final Gorev item;

  final IcerikCallback ekleItem;
  final IcerikCallback silItem;
  final IcerikCallback favItem;

  GosterGorev({this.ekleItem, this.silItem, this.favItem, this.item});

  @override
  GosterGorevState createState() => GosterGorevState();
}

class GosterGorevState extends State<GosterGorev> with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  final baslikText = TextEditingController();
  final aciklamaText = TextEditingController();

  void fav() {
    setState(() {
      widget.item.favori = !widget.item.favori;
    });
  }

  void sil() {
    setState(() {
      widget.silItem(widget.item);
      Navigator.pop(context);
    });
  }

  void hatirlat() {
    print(widget.item.sonZaman);
    setState(() {
      if(widget.item.sonZaman == null) {

        showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: RenkPaleti.ACIK_KIRMIZI,
                      ),
                    ),
                    primaryColor: RenkPaleti.ACIK_KIRMIZI,
                    primaryContrastingColor: RenkPaleti.ACIK_KIRMIZI,
                    scaffoldBackgroundColor: RenkPaleti.ACIK_KIRMIZI,
                    barBackgroundColor: RenkPaleti.ACIK_KIRMIZI,
                    brightness: Brightness.light,
                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        widget.item.sonZaman = newDate;
                      });
                    },
                    initialDateTime: DateTime.now().add(Duration(minutes: 1)),
                    use24hFormat: true,
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(Duration(days: 365*30)),
                    minimumYear: DateTime.now().year,
                    maximumYear: DateTime.now().year+20,
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    backgroundColor: CupertinoColors.white,
                  ),
                ),
              );
            }
        );

      } else {
        widget.item.sonZaman = null;
      }
    });
  }

  void renkDegistir(Color color) {
    setState(() {
      widget.item.renk = color;
    });
  }

  void kaydet() {

    print(baslikText.text);
    widget.item.baslik = baslikText.text;

    print(aciklamaText.text);
    widget.item.aciklama = aciklamaText.text;

    print("Renk: ");
    print(widget.item.renk.toString());

    // Add the item
    widget.ekleItem(widget.item);

    // Go back
    Navigator.pop(context);
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
            icon: (widget.item.sonZaman != null ? Icon(Icons.alarm) : Icon(Icons.add_alarm)),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.hatirlat();
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
            icon: Icon(EkleIcon.ucak, color: RenkPaleti.ACIK_KIRMIZI),
            color: RenkPaleti.ACIK_KIRMIZI,
            onPressed: () {
              this.fav();
            },
          ),
          IconButton(
            icon: (Icon(Icons.edit, color: RenkPaleti.ACIK_KIRMIZI,)),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => EkleGorev(
                ekleItem: widget.ekleItem,
                item: widget.item,
              )));
            },
          ),
          IconButton(
            icon: (Icon(Icons.delete_outline,color: RenkPaleti.ACIK_KIRMIZI,)),
            onPressed: () {
              this.sil();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 15,
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectableText(
                widget.item.baslik.substring(0,1).toUpperCase() + widget.item.baslik.substring(1),
                style: TextStyle(
                  color: Color(0xFFF2A8AB),
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                ),
                child: SelectableText(
                  DateFormat.yMMMd().format(widget.item.olusturmaZamani),
                  style: TextStyle(
                    color: Color(0xFFDDBFB8),
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: SelectableText(
                  widget.item.aciklama,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFFDEC1BA),
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                  cursorColor: RenkPaleti.ACIK_KIRMIZI,
                  cursorWidth: 3,
                  showCursor: true,
                  scrollPhysics: BouncingScrollPhysics(),
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: false,
                    paste: false,
                    selectAll: true,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}