import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import '../../../../../app/functions/product_functions.dart';
// import '../../../../../app/utils/my_flutter_app_icons.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../../../../app/providers/product.dart';
import '../../../../../app/providers/cart.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductGridItem extends StatefulWidget {
  final String pageType;
  ProductGridItem(this.pageType);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    // final Cart cart = Provider.of(context, listen: false);
    final Product product = Provider.of(context, listen: false);
    return Padding(
      padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                // CachedNetworkImage(
                //   imageUrl: product.images[0]['url'], //images[0]url,
                //   placeholder: (context, url) =>
                //       new CircularProgressIndicator(),
                //   errorWidget: (context, url, error) =>
                //       Center(child: Icon(Icons.error)),
                // ),
                Positioned(
                  top: 2,
                  right: 0,
                  child: Consumer<Product>(builder: (ctx, product, _) {
                    return InkWell(
                        onTap: () async {
                          product.toggleFavorite(ctx, widget.pageType,
                              'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                        },
                        child:
                            // kIsWeb
                            //     ?
                            Icon(
                          product.isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: 24,
                        )
                        // : NeumorphicIcon(
                        //     product.isFavorite
                        //         ? Icons.bookmark
                        //         : Icons.bookmark_border,
                        //     size: 24,
                        //     style: NeumorphicStyle(
                        //         color: Colors.black,
                        //         depth: 1,
                        //         intensity: 1,
                        //         lightSource: LightSource.lerp(
                        //             LightSource.bottom, LightSource.top, 1)),
                        //   ),
                        );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 24.0),
                child: LayoutBuilder(
                  builder: (context, size) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          product.subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            product.price != 0.00
                                ? product.promotion != 0.00
                                    ? Text(
                                        ProductFunctions()
                                            .doubleValueToCurrency(
                                                product.price),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Text(
                                        'R\$ ' +
                                            ProductFunctions()
                                                .doubleValueToCurrency(
                                                    product.price),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey[800],
                                        ),
                                      )
                                : Container(width: 0.0, height: 0.0),
                            product.promotion != 0.00
                                ? Text(
                                    ' / R\$ ' +
                                        ProductFunctions()
                                            .doubleValueToCurrency(
                                                product.promotion),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.red[800],
                                    ),
                                  )
                                : Container(width: 0.0, height: 0.0),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: Consumer<Product>(builder: (ctx, product, _) {
              //     return InkWell(
              //       onTap: () async {
              //         Scaffold.of(context).hideCurrentSnackBar();
              //         Scaffold.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(
              //               'Produto adicionado com sucesso!',
              //             ),
              //             duration: Duration(seconds: 2),
              //             action: SnackBarAction(
              //               label: 'DESFAZER',
              //               onPressed: () {
              //                 cart.removeSingleItem(product.id);
              //               },
              //             ),
              //           ),
              //         );
              //         cart.addItem(product);
              //       },
              //       child: Transform(
              //         alignment: Alignment.center,
              //         transform: Matrix4.rotationY(math.pi),
              //         child: Icon(
              //           MyFlutterApp.bag,
              //           size: 26,
              //         ),
              //       ),
              //     );
              //   }),
              // ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
