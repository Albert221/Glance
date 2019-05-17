import 'package:flutter/material.dart';

class IconNavigationBar extends StatefulWidget {
  final List<Widget> icons;
  final ValueChanged<int> onTap;
  final int currentIndex;

  final Duration animationDuration;

  const IconNavigationBar({
    Key key,
    @required this.icons,
    this.onTap,
    this.currentIndex = 0,
    this.animationDuration = const Duration(milliseconds: 300),
  })  : assert(icons != null),
        assert(icons.length >= 2),
        super(key: key);

  @override
  _IconNavigationBarState createState() => _IconNavigationBarState();
}

class _IconNavigationBarState extends State<IconNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final iconsColor = Theme.of(context).iconTheme.color;

    return Container(
      color: backgroundColor,
      child: Row(
        children: widget.icons.map((icon) {
          final index = widget.icons.indexOf(icon);

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: index != widget.currentIndex
                  ? () => widget.onTap(index)
                  : null,
              child: Container(
                height: 64.0,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: index == widget.currentIndex
                        ? iconsColor
                        : backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedTheme(
                    data: ThemeData(
                      iconTheme: IconThemeData(
                        color: index == widget.currentIndex
                            ? backgroundColor
                            : iconsColor,
                      ),
                    ),
                    child: icon,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
