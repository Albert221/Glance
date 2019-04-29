import 'package:flutter/material.dart';

class Upvoteable extends StatefulWidget {
  final Widget child;
  final double height;
  final VoidCallback onUpvote;

  const Upvoteable(
      {Key key, @required this.child, @required this.height, this.onUpvote})
      : assert(child != null),
        assert(height != null),
        super(key: key);

  @override
  _UpvoteableState createState() => _UpvoteableState();
}

class _UpvoteableState extends State<Upvoteable>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacityFirst;
  Animation<double> _opacitySecond;
  Animation<Alignment> _alignmentFirst;
  Animation<Alignment> _alignmentSecond;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _opacityFirst = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 1 / 4, curve: Curves.ease),
    ))
      ..addListener(() => setState(() {}));

    _opacitySecond = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(3 / 4, 1, curve: Curves.ease),
    ));

    _alignmentFirst =
        Tween(begin: Alignment.bottomCenter, end: Alignment.center)
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 1 / 3, curve: Curves.ease),
    ));

    _alignmentSecond =
        Tween(begin: Alignment.center, end: Alignment.bottomCenter).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(2 / 3, 1, curve: Curves.ease)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onUpvote() {
    if (widget.onUpvote == null) {
      return;
    }

    widget.onUpvote();
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onUpvote,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: widget.height),
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            Opacity(
              opacity: _opacityFirst.value - _opacitySecond.value,
              child: Container(
                color: Colors.black45,
                alignment: _alignmentFirst.value - _alignmentSecond.value,
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white54,
                  size: 128.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
