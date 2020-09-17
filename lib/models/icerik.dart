import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontask/ayarlar/sabitler.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:share/share.dart';
import 'dart:ui';
import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class Icerik{
  final String id = md5.convert(utf8.encode(DateTime.now().toString())).toString();
  String baslik;
  bool favori;
  String sifre;
  String aciklama;
  Color renk;
  DateTime olusturmaZamani;
  DateTime sonDegisimZamani;
  bool silindiMi;
  final int bildirimId = DateTime.now().millisecondsSinceEpoch;
  DateTime sonZaman;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  InitializationSettings initializationSettings;

  Icerik(baslik, favori, secured, sifre, aciklama, renk){
    this.baslik=baslik;
    this.favori=favori;
    this.sifre = sifre;
    this.aciklama = aciklama;
    if(renk !=null){
      this.renk = renk;
    }
    else{
      this.renk = RenkPaleti.randomColor();
    }

    this.olusturmaZamani=DateTime.now();
    this.sonDegisimZamani=DateTime.now();
    this.silindiMi = false;

    initializationSettings = InitializationSettings(
        initializationSettingsAndroid,
        initializationSettingsIOS
    );
  }

  String getBaslik(){
    return baslik;
  }

  String getAciklama();

  Color getRenk() {

    return this.renk;
  }

  Color getIconRenk(){
    return this.renk.computeLuminance()>0.7 ? Colors.black54:Colors.white;
  }

  IconData getIcon();

  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject();

    Share.share("${this.baslik} \n ${this.aciklama}",
      subject: this.aciklama,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void secure(String sifre) {
    this.sifre = sifre;
  }

  void unSecure() {
    this.sifre = null;
  }

  Future<void> showNotification() async {

    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload);
        }
    );

//    await flutterLocalNotificationsPlugin.cancel(notificationId);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'OnTask',
      'OnTask',
      'OnTask Bildirimler',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      enableLights: true,
      color: RenkPaleti.ACIK_KIRMIZI,
      ledColor: RenkPaleti.ACIK_KIRMIZI,
      ledOnMs: 60 * 60 * 1000,
      ledOffMs: 0,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics
    );

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'OnTask',
        'Sonraki Görev: ${this.baslik}',
        this.sonZaman,
        platformChannelSpecifics
    );
  }
}

