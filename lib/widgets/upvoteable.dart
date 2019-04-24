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

class _UpvoteableState extends State<Upvoteable> {
  bool animating = false;

  @override
  void initState() {
    super.initState();
  }

  void onUpvote() {
    if (widget.onUpvote == null) {
      return;
    }

    widget.onUpvote();

    setState(() {
      animating = true;
    });

    Future.delayed(
        Duration(milliseconds: 600), () => setState(() => animating = false));
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
            AnimatedOpacity(
              curve: Curves.ease,
              opacity: animating ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.ease,
                duration: Duration(milliseconds: 300),
                color: Colors.black45,
                alignment:
                    animating ? Alignment.center : Alignment.bottomCenter,
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
