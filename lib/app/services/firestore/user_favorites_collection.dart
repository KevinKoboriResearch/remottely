import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/product.dart';
import 'dart:async';

class UserFavoritesCollection {
  // final _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference _productsCollectionReference = Firestore
      .instance
      .collection('users')
      .document('FYRjAaP0FHSr6DoFSX5KwVzObcn1')//FirebaseAuth.instance.currentUser.uid)
      .collection('favorites');

  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();

  // #6: Create a list that will keep the paged results
  List<List<Product>> _allPagedResults = [];

  static const int ProductsLimit = 6;

  DocumentSnapshot _lastDocument;
  bool _hasMoreProducts = true;

  Stream listenToUserFavoriteProductsRealTime() {
    // Register the handler for when the products data changes
    _requestFavoriteProducts();
    return _productsController.stream;
  }

  // #1: Move the request products into it's own function
  void _requestFavoriteProducts() {
    // #2: split the query from the actual subscription
    Query pageProductsQuery = _productsCollectionReference
        .orderBy('companyTitle')
        // #3: Limit the amount of results
        .limit(ProductsLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pageProductsQuery = pageProductsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMoreProducts) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    Future<List<Product>> getNewProducts(
        List<DocumentSnapshot> products) async {
      List<Product> newProductList = [];

      for (int i = 0; i < products.length; i++) {
        var realProduct = await Firestore.instance
            .document(products[i].data['productReference'])
            .get();

        newProductList.add(Product(
          id: realProduct.documentID,
          coin: realProduct.data['coin'],
          companyTitle: realProduct.data['companyTitle'],
          categoryTitle: realProduct.data['categoryTitle'],
          description: realProduct.data['description'],
          enabled: realProduct.data['enabled'],
          images: realProduct.data['images'],
          interested: realProduct.data['interested'],
          price: realProduct.data['price'],
          promotion: realProduct.data['promotion'],
          rating: realProduct.data['rating'],
          sizes: realProduct.data['sizes'],
          subtitle: realProduct.data['subtitle'],
          title: realProduct.data['title'],
          quantity: realProduct.data['quantity'],
          isFavorite: true,
        ));
      }
      return newProductList;
    }

    pageProductsQuery.snapshots().listen((QuerySnapshot productsSnapshot) async {
   
      if (productsSnapshot.documents.isNotEmpty) {
        List<DocumentSnapshot> products = productsSnapshot.documents;
        List<Product> newProducts = [];
        if (products != null) {
          newProducts = await getNewProducts(products);
        }
        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;
        
        // #9: If the page exists update the products for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] =
              products == null ? [] : newProducts;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(newProducts);
        }

        // #11: Concatenate the full list to be shown
        var allProducts = _allPagedResults.fold<List<Product>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all products
        _productsController.add(allProducts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = productsSnapshot.documents.last;
        }

        // #14: Determine if there's more products to request
        _hasMoreProducts = newProducts.length == ProductsLimit;
      }
    });
  }

  void requestMoreUserFavoriteProductsData() => _requestFavoriteProducts();

  ///////////////////////////////////////////////////////////////////////

}
