import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
// import 'package:remottely/providers/devicesSnapshot.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
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
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Hero(
              tag: devicesSnapshot.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/kevinkobori.jpg'),
                image: NetworkImage(
                    devicesSnapshot['deviceImage']['deviceImageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: GridTileBar(
              // backgroundColor: Colors.grey,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NIKE',//devicesSnapshot['deviceTitle'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Camisa colorida da moda tal tal tal',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    'R\$ 80,00 ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
