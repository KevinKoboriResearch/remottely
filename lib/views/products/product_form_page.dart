import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remottely/models/image_model.dart';
import 'package:remottely/models/product_model.dart';
import 'package:remottely/data/firestore/products_collection.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/utils/via_cep_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/exceptions/http_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';

import 'package:remottely/functions/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:remottely/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:remottely/validators/product_validators.dart';

import 'package:remottely/styles/product_styles.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
//detect if user exist in firebase
//send request to become a manager
//show options for managers of device
//show option for invite device users?
//show users

class ProductFormPage extends StatefulWidget {
  final device;
  ProductFormPage(this.device);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  // var controller = new MaskedTextController(mask: '000.000.000-00');
  String zzz = "";
  final _descriptionFocusNode = FocusNode();
  final _coinFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _promotionFocusNode = FocusNode();
  final _subtitleFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _deviceIsLoading = false;
  double zz = 23542234;
  bool _isLoading = false;
  bool _enableField = true;
  // String _adressResult;
  Marker deviceMaker;
  Marker userMarker;
  List<Marker> deviceMarkers = [];
  final auth = FirebaseAuth.instance;
  // String _imageUrlRecovered;

  final ImagePicker _picker = ImagePicker();
  dynamic _decodedProfileImage;
  bool _uploadingImage = false;
  String sourceImagem;
  dynamic allImagesSelectedFile = []; //List<File>
  // List<Map<String, Object>> allImagesSelectedFile = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _coinFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _promotionFocusNode.dispose();
    _subtitleFocusNode.dispose();
    _titleFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      if (widget.device != null) {
        _formData['id'] = widget.device.id;
        _formData['coin'] = widget.device.data()['coin'];
        _formData['companyTitle'] = widget.device.data()['companyTitle'];
        _formData['description'] = widget.device.data()['description'];
        _formData['images'] = widget.device.data()['images'];
        _formData['interested'] = widget.device.data()['interested'];
        _formData['price'] = widget.device.data()['price'];
        _formData['promotion'] = widget.device.data()['promotion'];
        _formData['rating'] = widget.device.data()['rating'];
        _formData['subtitle'] = widget.device.data()['subtitle'];
        _formData['title'] = widget.device.data()['title'];
      } else {
        _formData['coin'] = 'R\$';
        _formData['companyTitle'] = 'kevinkobori';
      }
    }
  }

  Future<void> _saveForm() async {
    var imagesSelectedList = allImagesSelectedFile;

    var isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState.save();

    // var productForm
    //  = ProductModel(
    //   id: _formData['id'],
    //   companyTitle: _formData['companyTitle'],
    //   coin: _formData['coin'],
    //   description: _formData['description'],
    //   images: [],//allImagesSelectedFile,
    //   interested: [],//_formData['interested'],
    //   price: _formData['price'],
    //   promotion: _formData['promotion'],
    //   rating:1,// _formData['rating'],
    //   subtitle: _formData['subtitle'],
    //   title: _formData['title'],
    // );

    var productForm = ProductModel(
      id: _formData['id'],
      companyTitle: _formData['companyTitle'],
      coin: _formData['coin'],
      description: _formData['description'],
      images: [], //allImagesSelectedFile,
      interested: _formData['interested'],
      price: double.parse(_formData['price']),
      promotion: double.parse(_formData['promotion']),
      // rating: 1.0,
      subtitle: _formData['subtitle'],
      title: _formData['title'],
    );

    // print(productForm.images.toString());
    // print(productForm.interested.toString());
    // print(productForm.price.toString());
    // print(productForm.promotion.toString());print(productForm.images.toString());
    // print(productForm.images.toString());
    // print(productForm.images.toString());
    // print(productForm.images.toString());
    // print(productForm.images.toString());
    // print(productForm.images.toString());
    List<Map<String, Object>> testelistaa;
    setState(() {
      _deviceIsLoading = true;
    });
    var companyId = 'bwBiNTo7yOIUYehamSmD';

    Future productImagesUpdate(
        companyId, productId, allImagesSelectedFile) async {
      for (int i = 0; i < allImagesSelectedFile.length; i++) {
        print('5\n555\n555\n5555\n55555\n555555\n5555555\n55555555\n' +
            allImagesSelectedFile.toString());
        if (allImagesSelectedFile[i] is String) continue;

        var uploadTask = FirebaseStorage.instance
            .ref()
            .child(companyId)
            .child(productId)
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(allImagesSelectedFile[i]);
// var s =
        await uploadTask.whenComplete(() async {
          var downloadUrl = await (await uploadTask).ref.getDownloadURL();
          // String downloadUrl = await s.ref.getDownloadURL();
          //  var url = await (await task).ref.getDownloadURL();
          // var _decodedProfileImage = await decodeImageFromList(
          var val = await decodeImageFromList(
              // imagesSelectedList[i].readAsBytesSync());
              allImagesSelectedFile[i].readAsBytesSync()); //.then((value) {
          // allImagesSelectedFile.add({
          //   'height': val.height,
          //   'url': downloadUrl,
          //   'width': val.width,
          // });
          allImagesSelectedFile[i] = {
            'height': val.height,
            'url': downloadUrl,
            'width': val.width,
          };
        });
      }
    }

    try {
      if (_formData['id'] != null) {
        // await productImagesUpdate(companyId, _formData['id'],
        //     allImagesSelectedFile); //productImagesUpdate(product.documentID);
        // print('6\n666\n666\n6666\n66666\n666666\n6666666\n66666666\n' +
        //     allImagesSelectedFile.toString());
        // await ProductsCollection()
        //     .productInsert(companyId, productForm, allImagesSelectedFile);
        // // await product.reference.updateData(unsavedData);
      } else {
        // DocumentReference dr = await Firestore.instance
        //     .collection("products")
        //     .document(categoryId)
        //     .collection("items")
        //     .add(Map.from(unsavedData)..remove("images"));
        DocumentReference dr = await FirebaseFirestore.instance
            .collection('companies')
            .doc(companyId)
            .collection('products')
            .add({
          "coin": productForm.coin,
          'companyTitle': productForm.companyTitle,
          'description': productForm.description,
          'images': [],
          'interested': [],
          'price': productForm.price,
          'promotion': productForm.promotion,
          "rating": 0.0,
          'subtitle': productForm.subtitle,
          'title': productForm.title,
        });
        // await _uploadImages(dr.documentID);
        await productImagesUpdate(companyId, dr.id,
            allImagesSelectedFile); //productImagesUpdate(product.documentID);
        print('6\n666\n666\n6666\n66666\n666666\n6666666\n66666666\n' +
            allImagesSelectedFile.toString());
        // await dr.updateData(unsavedData);
        await FirebaseFirestore.instance
            .collection('companies')
            .doc(companyId)
            .collection('products')
            .doc(dr.id)
            .update({
          'images': allImagesSelectedFile,
        });
        // await ProductsCollection()
        //     .productUpdate(companyId, productForm, allImagesSelectedFile);
      }

      // try {
      //   if (_formData['id'] == null) {
      //      print(
      //             '1\n11\n111\n1111\n11111\n111111\n1111111\n11111111\n' +
      //                 imagesSelectedList.toString());
      //     // testelistaa =
      //     ProductsCollection()
      //         .productInsert(companyId, productForm, imagesSelectedList);
      //   } else {
      //     // await ProductsCollection().productUpdate(productForm);
      //   }
      // Navigator.of(context).pop();
      // } catch (error) {
      //   await showDialog<Null>(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //       title: Text('Ocorreu um erro!'),
      //       content: Text('Ocorreu um erro pra salvar o produto!'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('Fechar'),
      //           onPressed: () => Navigator.of(context).pop(),
      //         ),
      //       ],
      //     ),
      //   );
    } finally {
      // ProductsCollection().productImagesUpdate(companyId,'OSlClAmGC5tqMjoZYhhU',testelistaa);
      setState(() {
        _deviceIsLoading = false;
      });
    }
  }

  Future _getImage() async {
    PickedFile selectedImage;
    switch (sourceImagem) {
      case "camera":
        selectedImage = await _picker.getImage(source: ImageSource.camera);
        break;
      case "gallery":
        selectedImage = await _picker.getImage(source: ImageSource.gallery);
        break;
    }

    File cropped = await ImageCropper.cropImage(
      sourcePath: selectedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 720,
      maxHeight: 720,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.transparent,
        toolbarTitle: "Imagem",
        backgroundColor: Colors.white,
        cropFrameColor: AppColors.astratosDarkGreyColor,
        toolbarWidgetColor: AppColors.astratosDarkGreyColor,
        activeControlsWidgetColor: AppColors.accentColor,
      ),
    );

    setState(() {
      allImagesSelectedFile.add(File(cropped.path));
    });
    if (allImagesSelectedFile.length >= 5) {
      Navigator.of(context).pop();
      FocusScope.of(context).requestFocus(_titleFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.astratosDarkGreyColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MyFlutterApp.left_open_big,
            size: 20,
            color: AppColors.astronautCanvasColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "P R O D U T O",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Astronaut_PersonalUse',
            color: AppColors.astronautCanvasColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(MyFlutterApp.floppy),
            color: AppColors.astronautCanvasColor,
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _deviceIsLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    allImagesSelectedFile.length != 0
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width - 64,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: allImagesSelectedFile.length,
                              itemBuilder: (context, index) {
                                return Image.file(
                                  allImagesSelectedFile[index],
                                  width: MediaQuery.of(context).size.width - 64,
                                  height: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          )
                        : Stack(
                            children: [
                              FadeInImage(
                                height: MediaQuery.of(context).size.width - 128,
                                width: (kIsWeb
                                    ? 400
                                    : MediaQuery.maybeOf(context).size.width),
                                placeholder: AssetImage('assets/logo/logo.png'),
                                image: AssetImage('assets/logo/logo.png'),
                                fit: BoxFit.cover,
                              ),
                              // ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  allImagesSelectedFile.length >= 5
                                      ? 'Limite de fotos atingido'
                                      : 'Adicionar Foto',
                                  style: TextStyle(
                                    color: AppColors.astronautCanvasColor,
                                  ),
                                ),
                                onPressed: allImagesSelectedFile.length >= 5
                                    ? () {
                                        FocusScope.of(context)
                                            .requestFocus(_titleFocusNode);
                                      }
                                    : () {
                                        // _uploadingImage
                                        //     ? null
                                        //     :
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (_) => Container(
                                            height: 140,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 16.0,
                                                    left: 16.0,
                                                  ),
                                                  child: NeumorphicText(
                                                    'F O T O  D A  C H A V E',
                                                    style: NeumorphicStyle(
                                                      depth: 1,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                    textStyle:
                                                        NeumorphicTextStyle(
                                                      fontFamily:
                                                          'Astronaut_PersonalUse',
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 26),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 26),
                                                    Container(
                                                      width: 50,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              // _deleteImage();
                                                            },
                                                            child:
                                                                NeumorphicIcon(
                                                              MyFlutterApp
                                                                  .trash_1,
                                                              size: 40,
                                                              style:
                                                                  NeumorphicStyle(
                                                                depth: 1,
                                                                color: AppColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                          ),
                                                          Text('Todos'),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 46,
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              sourceImagem =
                                                                  "camera";
                                                              _getImage();
                                                            },
                                                            child:
                                                                NeumorphicIcon(
                                                              MyFlutterApp2
                                                                  .camera,
                                                              size: 40,
                                                              style:
                                                                  NeumorphicStyle(
                                                                depth: 1,
                                                                color: AppColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                          ),
                                                          Text('Câmera'),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 46,
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              sourceImagem =
                                                                  "gallery";
                                                              _getImage();
                                                            },
                                                            child:
                                                                NeumorphicIcon(
                                                              MyFlutterApp2
                                                                  .picture,
                                                              size: 40,
                                                              style:
                                                                  NeumorphicStyle(
                                                                depth: 1,
                                                                color: AppColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                          ),
                                                          Text('Galeria'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: 'teste',
                            textInputAction: TextInputAction.next,
                            focusNode: _titleFocusNode,
                            style: ProductStyles().inputTextStyle(),
                            decoration: ProductStyles().inputTextDecoration(
                                'Título', 'Camiseta de Malha Azul...'),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_subtitleFocusNode);
                            },
                            validator: (value) {
                              return ProductValidators().validateTitle(value);
                            },
                            onSaved: (value) => _formData['title'] = value,
                          ),
                          TextFormField(
                            initialValue: 'teste',
                            // autofocus: true,
                            textInputAction: TextInputAction.next,
                            focusNode: _subtitleFocusNode,
                            style: ProductStyles().inputTextStyle(),
                            decoration: ProductStyles().inputTextDecoration(
                                'Subtítulo', 'Lançamento/P e PP/36 a 44...'),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            onSaved: (value) => _formData['subtitle'] = value,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                layoutBehavior:
                                    ButtonBarLayoutBehavior.constrained,
                                minWidth: MediaQuery.of(context).size.width,
                                child: DropdownButton<String>(
                                  value: _formData['coin'],
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 0,
                                  dropdownColor: Colors.black,
                                  focusNode: _coinFocusNode,
                                  style: const TextStyle(
                                      color: AppColors.accentColor),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  items: <String>['R\$', 'US\$', '€']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _formData['coin'] = newValue;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(_priceFocusNode);
                                  },
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            initialValue: zz?.toStringAsFixed(2),
                            // autofocus: true,
                            focusNode: _priceFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: ProductStyles().inputTextStyle(),
                            decoration: ProductStyles()
                                .inputTextDecoration('Preço original', ''),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_promotionFocusNode);
                            },
                            validator: (val) {
                              return ProductValidators().validateCurrency(val);
                            },
                            onSaved: (value) {
                              double val = double.tryParse(value);
                              if (val != null) {
                                _formData['price'] = value;
                              } else {
                                _formData['price'] = 0.00;
                              }
                            },
                          ),
                          TextFormField(
                            initialValue: zz?.toStringAsFixed(2),
                            // autofocus: true,
                            focusNode: _promotionFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            style: ProductStyles().inputTextStyle(),
                            decoration: ProductStyles().inputTextDecoration(
                                'Preço em promoção?',
                                'Insira o valor com desconto aqui!'),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                            validator: (val) {
                              return ProductValidators().validateCurrency(val);
                            },
                            onSaved: (value) {
                              double val = double.tryParse(value);
                              if (val != null) {
                                _formData['promotion'] = value;
                              } else {
                                _formData['promotion'] = 0.00;
                              }
                            },
                          ),
                          TextFormField(
                            initialValue: '',
                            // autofocus: true,
                            minLines: 1,
                            maxLines: 12,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descriptionFocusNode,
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.map,
                                  color: AppColors.astratosDarkGreyColor),
                              hintText:
                                  'Entregamos por todo DF, de segunda a sábado...',
                              labelText: 'Descrição',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) =>
                                _formData['description'] = value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
