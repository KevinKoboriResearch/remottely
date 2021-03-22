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
import 'package:remottely/validators/product_validator.dart';
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
  double zz;
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
  List<File> allImagesSelectedFile = [];
  List<ImageModel> allImagesSelectedUrl = [];

  @override
  void initState() {
    super.initState();
    // _imageUrlRecovered = '';
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
    var isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState.save();

    if (allImagesSelectedFile != []) {
      _uploadingImage = true;
      allImagesSelectedUrl = [
        ImageModel(
          url: 'url',
          height: 1,
          width: 1,
        ),
        ImageModel(
          url: 'url',
          height: 1,
          width: 1,
        ),
        ImageModel(
          url: 'url',
          height: 1,
          width: 1,
        ),
        ImageModel(
          url: 'url',
          height: 1,
          width: 1,
        ),
        ImageModel(
          url: 'url',
          height: 1,
          width: 1,
        )
      ];
      // _uploadFileFirestoreInstance();
    }

    // var productForm
    //  = ProductModel(
    //   id: _formData['id'],
    //   companyTitle: _formData['companyTitle'],
    //   coin: _formData['coin'],
    //   description: _formData['description'],
    //   images: [],//allImagesSelectedUrl,
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
      coin: "_formData['coin']",
      description: _formData['description'],
      images: [], //allImagesSelectedUrl,
      interested: [], //_formData['interested'],
      price: double.parse(_formData['price']),
      promotion: double.parse(_formData['promotion']),
      rating: 1.0,
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

    setState(() {
      _deviceIsLoading = true;
    });
    var companyId = 'bwBiNTo7yOIUYehamSmD';
    try {
      if (_formData['id'] == null) {
        await ProductsCollection().productInsert(companyId, productForm);
      } else {
        await ProductsCollection().productUpdate(productForm);
      }
      // Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro pra salvar o produto!'),
          actions: <Widget>[
            // TextButton(
            //   child: Text('Fechar'),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
          ],
        ),
      );
    } finally {
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
        toolbarColor: Colors
            .transparent, //AppColors.astratosDarkGreyColor.withOpacity(0.7),
        toolbarTitle: "Imagem",
        // statusBarColor: Colors.deepOrange.shade900,
        backgroundColor: Colors.white,
        // cropGridColor: Colors.blue,
        cropFrameColor: AppColors.astratosDarkGreyColor,
        // dimmedLayerColor: AppColors.astronautCanvasColor,
        toolbarWidgetColor: AppColors.astratosDarkGreyColor,
        activeControlsWidgetColor: AppColors.accentColor,
      ),
    );

    setState(() {
      allImagesSelectedFile.add(File(cropped.path)); //selectedImage.path);
      // if (_selectedFile != null) {
      //   _uploadingImage = true;
      //   _uploadFileFirestoreInstance(sourceImagem);
      // }
    });
  }

  // File _selectedFile;
  // bool _inProcess = false;

  Widget getImageWidget() {
    if (allImagesSelectedFile != []) {
      List<Widget> WidgetsList = [];
      for (var imageFileSelected in allImagesSelectedFile) {
        WidgetsList.add(ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            imageFileSelected,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
        ));
      }

      Column(
        children: WidgetsList,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  Future _uploadFileFirestoreInstance() async {
    // allImagesSelectedFile; //pegar essa lista e inserir uma poor uma FOR
    // for (var imageFile in allImagesSelectedFile) {}
    // final archive = FirebaseStorage.instance
    //     .ref()
    //     .child('company')
    //     .child('product_images')
    //     .child(widget.device.id + '0.jpg');

    // UploadTask task = archive.putFile(archive);
    // task.snapshotEvents.listen((TaskSnapshot snapshot) {
    //   double _progress =
    //       snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble();
    //   print(_progress.toString() + '1');
    //   if (_progress < 1) {
    //     // setState(() {
    //     //   _uploadingImage = true;
    //     // });
    //   } else {
    //     if (sourceImagem == 'camera') {
    //       Timer(const Duration(milliseconds: 4500), () {
    //         // setState(() {
    //         //   _uploadingImage = false;
    //         // });
    //       });
    //     } else {
    //       Timer(const Duration(milliseconds: 2000), () {
    //         // setState(() {
    //         //   _uploadingImage = false;
    //         // });
    //       });
    //     }
    //   }
    //   print(_progress.toString() + '2');
    // });

    // task.whenComplete(() {
    //   _updateimage(task);
    // });
  }

  _updateimage(dynamic task) async {
    // var url = await (await task).ref.getDownloadURL();
    // _decodedProfileImage =
    //     await decodeImageFromList(allImagesSelectedFile.add(adAsBytesSync());
    // deviceUpdateImage(widget.device.id, url, _decodedProfileImage)
    //     .then((value) {
    //   setState(() {
    //     _imageUrlRecovered = url;
    //   });
    // });
  }

  Future<void> deviceUpdateImage(deviceId, url, decodedProfileImage) async {
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('$deviceId')
        .update({
      "image": {
        "imageUrl": url,
        "imageHeight": decodedProfileImage.height,
        "imageWidth": decodedProfileImage.width,
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.green));
    }

    final _fieldStyle = TextStyle(
      // color: Colors.white, fontSize: 16
      letterSpacing: 2,
      color: AppColors.accentColor,
    );

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
                                          builder: (_) {
                                            Container(
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
                                            );
                                          },
                                        );
                                      },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: '',
                            // autofocus: true,
                            textInputAction: TextInputAction.next,
                            // focusNode: _titleFocusNode,
                            onSaved: (value) => _formData['title'] = value,
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search,
                                  color: AppColors.astratosDarkGreyColor),
                              hintText: 'Camiseta de Malha Azul...',
                              labelText: 'Título',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_subtitleFocusNode);
                            },
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              bool isInvalid = value.trim().length < 2;
                              if (isEmpty || isInvalid) {
                                return 'Informe um título válido com no mínimo 2 caracteres!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: '',
                            // autofocus: true,
                            textInputAction: TextInputAction.next,
                            focusNode: _subtitleFocusNode,
                            onSaved: (value) => _formData['subtitle'] = value,
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.location_city,
                                  color: AppColors.astratosDarkGreyColor),
                              hintText: 'Lançamento/P e PP/36 a 44...',
                              labelText: 'Subtítulo',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                // alignedDropdown: true,
                                padding: EdgeInsets.all(90),
                                layoutBehavior:
                                    ButtonBarLayoutBehavior.constrained,
                                minWidth: MediaQuery.of(context).size.width,
                                child: DropdownButton<String>(
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  // autofocus: true,
                                  // hint: Text(
                                  //   'Escolha a moeda',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     letterSpacing: 2,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: AppColors.astratosDarkGreyColor,
                                  //   ),
                                  // ),
                                  value: _formData['coin'],
                                  dropdownColor: Colors.black,
                                  elevation: 0,
                                  focusNode: _coinFocusNode,
                                  style: const TextStyle(
                                      color: AppColors.accentColor),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _formData['coin'] = newValue;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(_priceFocusNode);
                                  },
                                  items: <String>['R\$', 'US\$', '€']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  // style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            //                             void savePrice(String price){
                            //   unsavedData["price"] = double.parse(price);
                            // }
                            initialValue: zz?.toStringAsFixed(2),
                            style: _fieldStyle,
                            decoration: _buildDecoration("Preço"),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            // onSaved: _productBloc.savePrice,
                            // style: TextStyle(
                            //   letterSpacing: 2,
                            //   color: AppColors.accentColor,
                            // ),
                            validator: (val) {
                              return ProductValidator().validatePrice(val);
                            },
                          ),
                          TextFormField(
                            initialValue: zz?.toStringAsFixed(2),
                            // autofocus: true,
                            focusNode: _priceFocusNode,
                            textInputAction: TextInputAction.next,
                            // keyboardType: TextInputType.numberWithOptions(signed: true),
                            // inputFormatters: [CurrencyTextInputFormatter()],
                            keyboardType: TextInputType.number,
                            onSaved: (value) => _formData['price'] = value,
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.location_city,
                                  color: AppColors.astratosDarkGreyColor),
                              hintText: '',
                              labelText: 'Preço original',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_promotionFocusNode);
                            },
                            onChanged: (val) {
                              var value = double.parse(val);
                              // var rr = formatCurrency(value);
                              // String formatCurrency(num value,
                              //     {int fractionDigits = 2}) {
                              ArgumentError.checkNotNull(value, 'value');

                              // convert cents into hundreds.
                              value = value / 100;

                              // }
                              setState(() {
                                zzz = NumberFormat.currency(
                                        customPattern: '###,###.##',
                                        // using Netherlands because this country also
                                        // uses the comma for thousands and dot for decimal separators.
                                        locale: 'nl_NL')
                                    .format(value);
                              });
                              // var f = 1;
                              // value = "6.99";
                              // var v = double.parse(value);
                              // print(v);
                              // var numero2 = double.parse(v.toStringAsFixed(2));
                              // bool isEmpty = value.trim().isEmpty;
                              // // bool isInvalid = value.contains('.');//.trim().length < 2;
                              // if (z == 6.99) {
                              // print(numero2);
                              // setState(() {
                              // zzz;
                              // });
                              return null; //z.toString(); //'ele é double';
                              // }
                              // if (isEmpty || isInvalid) {
                              // }
                              // return null;,
                            },
                            validator: (val) {
                              var value = double.parse(val);
                              // var rr = formatCurrency(value);
                              // String formatCurrency(num value,
                              //     {int fractionDigits = 2}) {
                              ArgumentError.checkNotNull(value, 'value');

                              // convert cents into hundreds.
                              value = value / 100;

                              zzz = NumberFormat.currency(
                                      customPattern: '###,###.##',
                                      // using Netherlands because this country also
                                      // uses the comma for thousands and dot for decimal separators.
                                      locale: 'nl_NL')
                                  .format(value);
                              // }

                              // var f = 1;
                              // value = "6.99";
                              // var v = double.parse(value);
                              // print(v);
                              // var numero2 = double.parse(v.toStringAsFixed(2));
                              // bool isEmpty = value.trim().isEmpty;
                              // // bool isInvalid = value.contains('.');//.trim().length < 2;
                              // if (z == 6.99) {
                              // print(numero2);
                              // setState(() {
                              //   _formData['price'] = z;
                              // });
                              final oCcy =
                                  new NumberFormat("#,##0.00", "en_US");
                              var kk = oCcy.format(123456789.75);
                              // return kk;
                              return null; //zzz.toString(); //'ele é double';
                              // }
                              // if (isEmpty || isInvalid) {
                              // }
                              // return null;
                            },
                          ),
                          TextFormField(
                            initialValue: '',
                            // autofocus: true,
                            focusNode: _promotionFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onSaved: (value) => _formData['promotion'] = value,
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.location_city,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintText: 'Insira o valor com desconto aqui!',
                              labelText: 'Preço em promoção?',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                          ),
                          TextFormField(
                            initialValue: '',
                            // autofocus: true,
                            onSaved: (value) =>
                                _formData['description'] = value,
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
