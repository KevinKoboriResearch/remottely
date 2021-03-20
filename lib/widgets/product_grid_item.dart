import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
// import 'package:remottely/providers/devicesSnapshot.dart';
import 'package:remottely/providers/cart.dart';
import 'package:remottely/utils/app_routes.dart';
import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductGridItem extends StatelessWidget {
  final devicesSnapshot;
  ProductGridItem(this.devicesSnapshot);
  @override
  Widget build(BuildContext context) {
    // final Product devicesSnapshot = Provider.of(context, listen: false);
    // final Cart cart = Provider.of(context, listen: false);
    // final Auth auth = Provider.of(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: devicesSnapshot,
              );
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 396,
                      height: 396,
                      child: Hero(
                        tag: devicesSnapshot.id,
                        child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/kevinkobori.jpg'),
                          image: NetworkImage(devicesSnapshot['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Consumer<Product>(
                //   builder: (ctx, devicesSnapshot, _) => Padding(
                //     padding: EdgeInsets.all(devicesSnapshot.isFavorite ? 0.0 : 2.0),
                //     child: IconButton(
                //       splashColor: Colors.transparent,
                //       hoverColor: Colors.transparent,
                //       focusColor: Colors.transparent,
                //       icon: Icon(
                //         devicesSnapshot.isFavorite
                //             ? MyFlutterApp.heart_1
                //             : MyFlutterApp.heart_2,
                //         size: devicesSnapshot.isFavorite ? 16 : 12,
                //       ),
                //       iconSize: devicesSnapshot.isFavorite ? 28 : 22,
                //       color: Theme.of(context).accentColor,
                //       onPressed: () {
                //         // devicesSnapshot.toggleFavorite(auth.token, auth.userId);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(2.0),
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ), //BorderRadius.circular(4),
              child: GridTileBar(
                backgroundColor: Colors.white.withOpacity(0.96),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      devicesSnapshot['title'],
                      // textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    // Container(
                    //   width: 100,
                    //   child: 
                      Row(
                        children: [
                          Text(
                            devicesSnapshot[
                                'title'], //price.toString() + ',00 ',
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            devicesSnapshot['title'], //.quantity,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    // ),
                  ],
                ),
                // trailing: Row(
                //   children: [
                //     IconButton(
                //       icon: Icon(
                //         MyFlutterApp.bag,
                //         size: 16,
                //       ),
                //       color: Colors.blue,
                //       onPressed: () {
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
                //                 // cart.removeSingleItem(devicesSnapshot.id);
                //               },
                //             ),
                //           ),
                //         );
                //         // cart.addItem(devicesSnapshot);
                //       },
                //     ),
                //     // Consumer<Product>(
                //     //   builder: (ctx, devicesSnapshot, _) => Padding(
                //     //     padding: EdgeInsets.symmetric(
                //     //         horizontal: devicesSnapshot.isFavorite ? 0.0 : 2.0),
                //     //     child: IconButton(
                //     //       icon: Icon(
                //     //         devicesSnapshot.isFavorite
                //     //             ? MyFlutterApp.heart_1
                //     //             : MyFlutterApp.heart_2,
                //     //         size: 16,
                //     //       ),
                //     //       iconSize: devicesSnapshot.isFavorite ? 28 : 22,
                //     //       color: Theme.of(context).accentColor,
                //     //       onPressed: () {
                //     //         devicesSnapshot.toggleFavorite(auth.token, auth.userId);
                //     //       },
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
