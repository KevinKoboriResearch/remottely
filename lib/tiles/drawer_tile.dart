import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  // final PageonCountChanged onCountChanged;
  Function(int) onCountChanged;
  final int page;

  // DrawerTile(this.icon, this.text, this.onCountChanged, this.page);
  DrawerTile({
    @required this.icon,
    @required this.text,
    @required this.onCountChanged,
    @required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          onCountChanged(page);
          Navigator.of(context).pop();
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                // color: onCountChanged(page) == page ?
                //   Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  // color: onCountChanged(page) == page ?
                  // Theme.of(context).primaryColor : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
