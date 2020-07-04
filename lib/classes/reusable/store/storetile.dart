import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../locale.dart';
import 'details.dart';

class StoreTile extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String link;

  const StoreTile({Key key, this.image, this.title, this.subtitle, this.link})
      : super(key: key);

  @override
  _StoreTile createState() => _StoreTile();
}

class _StoreTile extends State<StoreTile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Inter', color: CupertinoTheme.of(context).primaryContrastingColor),
      child: Container(
        height: 70.0,
        padding: EdgeInsets.only(left: 10.0, right: 10.0,),
        child: GestureDetector(
          child: ListTile(
            title: Text(widget.title, style: TextStyle(fontFamily: 'Inter', color: CupertinoTheme.of(context).primaryContrastingColor, fontSize: 19.0)),
            subtitle: Text(widget.subtitle, style: TextStyle(fontFamily: 'Inter', color: CupertinoColors.inactiveGray, fontSize: 16.0)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(widget.image),
            ),
            onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => Details(
                        widget.title, widget.image, widget.subtitle, widget.link))),
            onLongPress: () {
              Translation translation = Translation.of(context);
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(widget.title + translation.storeSheetTitle),
                  message: Text(translation.storeSheetSubtitle),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text(translation.generalReport),
                      onPressed: () {
                        launch('https://t.me/iamcosmin');
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text(translation.generalCancel),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
