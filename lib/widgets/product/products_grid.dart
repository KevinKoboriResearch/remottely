import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remottely/widgets/product/product_grid_item.dart';
// import 'package:remottely/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/auth.dart';
// import 'package:remottely/providers/product.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProductsGrid extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> devicesSnapshot;
  ProductsGrid(this.devicesSnapshot);

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<Products>(context);
    // final products = showFavoriteOnly
    //     ? productsProvider.favoriteItems
    //     : productsProvider.items;

    return SliverPadding(
      padding: EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 210,
          childAspectRatio: 0.73,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductGridItem(devicesSnapshot.data.docs[index]);//Container(height: 100, color: Colors.red);
            // return ChangeNotifierProvider.value(
            //   value: products[index],
            //   child: ProductGridItem(),
            // );
          },
          childCount: devicesSnapshot.data.docs.length,//products.length, // widget.devicesSnapshot.data.docs.length,
        ),
      ),
    );
  }
}
