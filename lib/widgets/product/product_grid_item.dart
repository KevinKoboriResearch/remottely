import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
// import 'package:remottely/providers/widget.devicesSnapshot.dart';
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

class ProductGridItem extends StatefulWidget {
  final devicesSnapshot;
  ProductGridItem(this.devicesSnapshot);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Hero(
              tag: widget.devicesSnapshot.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/kevinkobori.jpg'),
                image: NetworkImage(
                    widget.devicesSnapshot['deviceImage']['deviceImageUrl']),
                fit: BoxFit.cover,
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'REMOTTELY', //widget.devicesSnapshot['deviceTitle'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Camisa colorida da moda tal tal tal tal tal tal tal tal tal tal tal tal tal',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '' + '80.900', //acima de tanto, remover os centavos?
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  decoration: TextDecoration.lineThrough
                                ),
                              ),
                              Text(
                                ' / R\$ ' + '50.900',//acima de tanto, remover os centavos?
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(
                  Icons.bookmark_border,
                  size: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
