import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductGridItem extends StatefulWidget {
  final snapshotProduct;
  ProductGridItem(this.snapshotProduct);
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
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Hero(
              tag: widget.snapshotProduct.id,
              child: CachedNetworkImage(
                imageUrl: widget.snapshotProduct['images'][0]['url'],
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Spacer(),
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
                          widget.snapshotProduct['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.snapshotProduct['subtitle'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              'R\$ ' +
                                  widget.snapshotProduct['price']
                                      .toString(), //acima de tanto, remover os centavos?
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                                decoration:
                                    widget.snapshotProduct['promotion'] !=
                                            ''
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                              ),
                            ),
                            widget.snapshotProduct['promotion'] != ''
                                ? Text(
                                    ' / R\$ ' +
                                        widget.snapshotProduct['promotion']
                                            .toString(), //acima de tanto, remover os centavos?
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[800],
                                    ),
                                  )
                                : Container(),
                          ],
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
