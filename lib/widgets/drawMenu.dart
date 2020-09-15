import 'package:flutter/material.dart';

class DrawMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
/*                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg')),*/
            ),
          ),

          ListTile(
            leading: Icon(Icons.restore_from_trash),
            title: Text('Görevi Geri Dönüştür'),
            onTap: () => {},
          ),

          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Geri Bildirim'),
            onTap: () => {Navigator.of(context).pop()},
          ),

        ],
      ),
    );
  }
}