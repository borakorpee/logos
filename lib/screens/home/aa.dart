// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class aaa extends StatelessWidget {
  const aaa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          NewWidget(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              width: 100,
              height: 200,
            ),
          ),
          SliverPersistentHeader(
            delegate: _HeaderSliver(),
            pinned: true,
          ),
          for (var i = 0; i < 26; i++) ...[
            SliverPersistentHeader(delegate: _header())
          ]
        ],
      ),
    );
  }
}

class _header extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Text("asdads");
  }

  @override
  double get maxExtent => 70.h;

  @override
  double get minExtent => 70.h;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

var _maxheighy = 100.h;

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  double get maxExtent => _maxheighy;

  @override
  double get minExtent => _maxheighy;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 50,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.zoomBackground],
        background: Center(child: Text("asdasd")),
      ),
    );
  }
}
