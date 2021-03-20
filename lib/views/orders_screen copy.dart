import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = 900;
    var w = 800;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.green,
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) => new StaggeredTile.count(
            2,
            index.isEven ? 2 * h / w : 2 * h / w,
          ),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
