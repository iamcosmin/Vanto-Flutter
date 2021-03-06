import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SettingsItemType {
  // Just on and off.
  toggle,
  // Navigates to another page of detailed settings.
  modal,
}

typedef Future<void> PressOperationCallback();

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    @required this.type,
    @required this.label,
    this.onChanged,
    this.subtitle,
    this.iconAssetLabel,
    this.value,
    this.hasDetails = false,
    this.onPress,
    this.val
  }) : assert(label != null),
        assert(type != null);

  final String label;
  final String subtitle;
  final String iconAssetLabel;
  final SettingsItemType type;
  final String value;
  final bool hasDetails;
  final PressOperationCallback onPress;
  final void Function(bool) onChanged;
  final bool val;

  @override
  State<StatefulWidget> createState() => new SettingsItemState();
}

class SettingsItemState extends State<SettingsItem> {
  bool switchValue = false;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    if (widget.iconAssetLabel != null) {
      rowChildren.add(
        Container(
          padding: const EdgeInsets.only(
            left: 15.0,
            bottom: 2.0,
          ),
          child: Container(
            height: 29.0,
            width: 29.0,
            child: Image.network(
                widget.iconAssetLabel
            ),
          ),
          color: CupertinoTheme.of(context).primaryColor,
        ),
      );
    }

    Widget titleSection;
    if (widget.subtitle == null) {
      titleSection = Container(
        padding: EdgeInsets.only(top: 1.5),
        child: Text(widget.label,style: TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor, fontSize: 17.0,)),
        color: CupertinoTheme.of(context).primaryColor,
      );
    } else {
      titleSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 8.5), color: CupertinoTheme.of(context).primaryColor,),
          Text(widget.label),
          Container(padding: EdgeInsets.only(top: 4.0), color: CupertinoTheme.of(context).primaryColor,),
          Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: 12.0,
              letterSpacing: -0.2,
              color: CupertinoTheme.of(context).primaryContrastingColor,
            ),
          )
        ],
      );
    }

    rowChildren.add(
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          color: CupertinoTheme.of(context).primaryColor,
          child: titleSection,
        ),
      ),
    );

    switch (widget.type) {
      case SettingsItemType.toggle:
        rowChildren.add(
          Container(
            padding: const EdgeInsets.only(right: 11.0),
              color: CupertinoTheme.of(context).primaryColor,
              child: CupertinoSwitch(
              value: widget.val,
              onChanged: widget.onChanged
            ),
          ),
        );
        break;
      case SettingsItemType.modal:
        final List<Widget> rightRowChildren = [];
        if (widget.value != null) {
          rightRowChildren.add(
            Container(
              padding: const EdgeInsets.only(
                top: 1.5,
                right: 2.25,
              ),
              color: CupertinoTheme.of(context).primaryColor,
              child: Text(
                widget.value,
                style: TextStyle(color: CupertinoColors.inactiveGray, fontSize: 15.0),
              ),
            ),
          );
        }

        if (widget.hasDetails) {
          rightRowChildren.add(
            Container(
              padding: const EdgeInsets.only(
                top: 0.5,
                left: 2.25,
              ),
              color: CupertinoTheme.of(context).primaryColor,
              child: Icon(
                CupertinoIcons.forward,
                color: CupertinoColors.inactiveGray,
                size: 21.0,
              ),
            ),
          );
        }

        rightRowChildren.add(Container(
          padding: const EdgeInsets.only(right: 8.5),
            color: CupertinoTheme.of(context).primaryColor,
        ));


        rowChildren.add(
          Row(
            children: rightRowChildren,
          ),
        );
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.onPress != null) {
            setState(() { pressed = true; });
            widget.onPress().whenComplete(() {
              Future.delayed(
                Duration(milliseconds: 150),
                    () { setState(() { pressed = false; }); },
              );
            });
          }
        },
        child: SizedBox(
          height: widget.subtitle == null ? 44.0 : 57.0,
          child: Row(
            children: rowChildren,
          ),
        ),
      ),
    );
  }
}