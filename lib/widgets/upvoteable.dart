import 'package:flutter/material.dart';

class Upvoteable extends StatefulWidget {
  final Widget child;
  final VoidCallback onUpvote;

  const Upvoteable({Key key, this.onUpvote, @required this.child})
      : assert(child != null),
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
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onDoubleTap: onUpvote,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: width),
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
