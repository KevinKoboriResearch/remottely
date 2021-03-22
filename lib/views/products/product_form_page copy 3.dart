import 'package:flutter/material.dart';
import 'package:remottely/models/image_model.dart';
import 'package:remottely/models/product_model.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
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
  final _descriptionFocusNode = FocusNode();
  final _coinFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _promotionFocusNode = FocusNode();
  final _subtitleFocusNode = FocusNode();
  // final _titleFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _deviceIsLoading = false;

  bool _isLoading = false;
  bool _enableField = true;
  String _adressResult;
  Marker deviceMaker;
  Marker userMarker;
  List<Marker> deviceMarkers = [];
  final auth = FirebaseAuth.instance;
  String _imageUrlRecovered;

  final ImagePicker _picker = ImagePicker();
  dynamic _decodedProfileImage;
  bool _uploadingImage = false;
  String sourceImagem;
  List<File> allImagesFileSelected = [];
  List<ImageModel> allImagesUrlSelected = [];

  @override
  void initState() {
    super.initState();
    _imageUrlRecovered = '';
  }

  @override
  void dispose() {
    super.dispose();
    _coinFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _promotionFocusNode.dispose();
    _subtitleFocusNode.dispose();
    // _titleFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      _formData['coin'] = 'R\$';
      if (widget.device != null) {
        _formData['id'] = widget.device.id;
        _formData['coin'] = widget.device.data()['coin'];
        _formData['companyTitle'] = widget.device.data()['companyTitle'];
        _formData['description'] = widget.device.data()['description'];
        _formData['image'] = widget.device.data()['image'];
        _formData['images'] = widget.device.data()['images'];
        _formData['interested'] = widget.device.data()['interested'];
        _formData['price'] = widget.device.data()['price'];
        _formData['promotion'] = widget.device.data()['promotion'];
        _formData['rating'] = widget.device.data()['rating'];
        _formData['subtitle'] = widget.device.data()['subtitle'];
        _formData['title'] = widget.device.data()['title'];
      }
    }
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState.save();

    if (allImagesFileSelected != []) {
      // _uploadingImage = true;
      //   final allImagesUrlSelected = [
      //   ImageModel(
      //     url: 'url',
      //     height: 1,
      //     width: 1,
      //   ),
      //   ImageModel(
      //     url: 'url',
      //     height: 1,
      //     width: 1,
      //   ),
      //   ImageModel(
      //     url: 'url',
      //     height: 1,
      //     width: 1,
      //   ),
      //   ImageModel(
      //     url: 'url',
      //     height: 1,
      //     width: 1,
      //   ),
      //   ImageModel(
      //     url: 'url',
      //     height: 1,
      //     width: 1,
      //   )
      // ];
      _uploadFileFirestoreInstance();
    }

    final productForm = ProductModel(
      id: _formData['id'],
      companyTitle: _formData['companyTitle'],
      coin: _formData['coin'],
      description: _formData['description'],
      images: allImagesUrlSelected,
      interested: _formData['interested'],
      price: _formData['price'],
      promotion: _formData['promotion'],
      rating: _formData['rating'],
      subtitle: _formData['subtitle'],
      title: _formData['title'],
    );

    setState(() {
      _deviceIsLoading = true;
    });

    try {
      if (_formData['id'] == null) {
        await DevicesCollection().deviceInsert(productForm);
      } else {
        await DevicesCollection().deviceUpdate(productForm);
      }
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro pra salvar o produto!'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
      maxWidth: 1080,
      maxHeight: 1080,
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
      allImagesFileSelected.add(File(cropped.path)); //selectedImage.path);
      // if (_selectedFile != null) {
      //   _uploadingImage = true;
      //   _uploadFileFirestoreInstance(sourceImagem);
      // }
    });
  }

  // File _selectedFile;
  // bool _inProcess = false;

  Widget getImageWidget() {
    if (allImagesFileSelected != []) {
      List<Widget> WidgetsList = [];
      for (var imageFileSelected in allImagesFileSelected) {
        WidgetsList.add(ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            imageFileSelected,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
          // FadeInImage(
          //   height: 220,
          //   width: (kIsWeb
          //       ? 400
          //       : MediaQuery.maybeOf(context).size.width),
          //   placeholder: AssetImage('assets/logo/logo.png'),
          //   image: _imageUrlRecovered != ''
          //       ? NetworkImage(_imageUrlRecovered)
          //       : AssetImage('assets/logo/logo.png'),
          //   fit: BoxFit.cover,
          // ),
        ));
      }
      return Column(children: WidgetsList);
      // return Row(
      //         children: allImagesFileSelected
      //         Image.file(
      //     _selectedFile,
      //     width: 250,
      //     height: 250,
      //     fit: BoxFit.cover,
      //   ),
      // );
      //  return Align(
      //     alignment: Alignment.bottomLeft,
      //     child: Container(
      //       width: 300, //MediaQuery.of(context).size.width,
      //       child: ListView(
      //         scrollDirection: Axis.horizontal,
      //         children: WidgetsList,
      //         // allImagesFileSelected.map((imageFileSelected) {
      //         //   return ClipRRect(
      //         //     borderRadius: BorderRadius.circular(12),
      //         //     child: Container(
      //         //       width: 300,
      //         //       color: Colors.red,
      //         //       // child: Image.file(
      //         //       //   imageFileSelected,
      //         //       //   width: 250,
      //         //       //   height: 250,
      //         //       //   fit: BoxFit.cover,
      //         //       // ),
      //         //     ),
      //         //   );
      //         // }).toList(),
      //       ),
      //     ),
      //   );
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
    // allImagesFileSelected; //pegar essa lista e inserir uma poor uma FOR
    // for (var imageFile in allImagesFileSelected) {}
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
    //     await decodeImageFromList(allImagesFileSelected.add(adAsBytesSync());
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
      body: ListView.builder(
  itemCount: 1,//allImagesFileSelected.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('oi'),
    );
  },
)

      // ListView( children: [
      //             // devicesSnapshot.data.docs.map((device) {
      //             //   double test = devicesSnapshot.data.docs.first.id == device.id
      //             //       ? 7.0
      //             //       : 0.0;
      //             // return
      //             Container(
      //               width: 100,
      //               height: 100,
      //             ),
      //           ]
      //               // }).toList(),
      //               ),
    );
  }
}
