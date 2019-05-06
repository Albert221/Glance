import 'dart:async';

import 'package:flutter/material.dart';

class InfiniteList extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final void Function(Completer) fetchMore;

  const InfiniteList(
      {Key key, this.itemCount, this.itemBuilder, this.fetchMore})
      : super(key: key);

  @override
  _InfiniteListState createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final _scrollController = ScrollController();
  double Function() _offsetToLoad = () => 0;
  Completer completer = Completer()..complete();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels + _offsetToLoad() >= position.maxScrollExtent &&
          completer.isCompleted) {
        completer = Completer();
        widget.fetchMore(completer);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _offsetToLoad = () => MediaQuery.of(context).size.height * 3;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}
