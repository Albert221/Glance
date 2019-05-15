import 'package:flutter/material.dart';

class NsfwOverlay extends StatelessWidget {
  final double height;
  final bool show;
  final VoidCallback onShow;

  const NsfwOverlay(
      {Key key, @required this.height, this.show = false, this.onShow})
      : assert(height != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: show,
      child: GestureDetector(
        onTap: onShow,
        child: AnimatedOpacity(
          opacity: show ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          child: Container(
            width: double.infinity,
            height: height,
            color: Colors.black,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'NSFW',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12.0),
                const Icon(
                  Icons.block,
                  size: 48.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
