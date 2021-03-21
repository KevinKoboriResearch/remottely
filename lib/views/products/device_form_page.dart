import 'package:flutter/material.dart';
import 'package:remottely/models/device_model.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/functions/streams.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui';
import 'dart:convert';
import 'package:remottely/models/user_model.dart';
import 'package:provider/provider.dart';
//detect if user exist in firebase
//send request to become a manager
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
//show options for managers of device
//show option for invite device users?
//show users

class DeviceFormPage extends StatefulWidget {
  final device;
  DeviceFormPage(this.device);

  @override
  _DeviceFormPageState createState() => _DeviceFormPageState();
}

class _DeviceFormPageState extends State<DeviceFormPage> {
  final _deviceTitleFocusNode = FocusNode();
  final _deviceCepFocusNode = FocusNode();
  final _deviceAdressFocusNode = FocusNode();
  final _deviceLatFocusNode = FocusNode();
  final _deviceLonFocusNode = FocusNode();
  final _deviceImageUrlFocusNode = FocusNode();
  final _deviceFormKey = GlobalKey<FormState>();
  final _deviceFormData = Map<String, Object>();
  bool _deviceIsLoading = false;
  var _searchByCepController = TextEditingController();
  bool _isLoading = false;
  bool _enableField = true;
  String _adressResult;
  Marker deviceMaker;
  Marker userMarker;
  List<Marker> deviceMarkers = [];
  final auth = FirebaseAuth.instance;
  // Position position;
  String _imageUrlRecovered;

  @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
    // if (widget.device == null && !kIsWeb) _getLastKnowUserLocation();
    _imageUrlRecovered = widget.device == null
        ? ''
        : widget.device.data()['deviceImage']['deviceImageUrl'];
  }

  @override
  void dispose() {
    super.dispose();
    // CheckInternet().listener.cancel();
    _deviceTitleFocusNode.dispose();
    _deviceCepFocusNode.dispose();
    _deviceLatFocusNode.dispose();
    _deviceLonFocusNode.dispose();
    _deviceAdressFocusNode.dispose();
    _deviceImageUrlFocusNode.dispose();
    _searchByCepController.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_deviceFormData.isEmpty) {
      if (widget.device != null) {
        _deviceFormData['id'] = widget.device.id;
        _deviceFormData['deviceProperty'] =
            widget.device.data()['deviceProperty'];
        _deviceFormData['deviceTitle'] = widget.device.data()['deviceTitle'];
        _deviceFormData['deviceAdress'] = widget.device.data()['deviceAdress'];
        _deviceFormData['deviceLat'] = widget.device.data()['deviceLat'];
        _deviceFormData['deviceLon'] = widget.device.data()['deviceLon'];
        _deviceFormData['devicetriggerUrl'] =
            widget.device.data()['devicetriggerUrl'];
             _deviceFormData['deviceImage'] =
            widget.device.data()['deviceImage'];
        _deviceFormData['deviceUsers'] = widget.device.data()['deviceUsers'];
        _deviceFormData['deviceManagers'] =
            widget.device.data()['deviceManagers'];
        _deviceFormData['deviceVerified'] =
            widget.device.data()['deviceVerified'];
      }
    }
  }

  _showLocatorDialog() {
    return showFlushbar(
      context,
      'A criação dessa chave se baseia em sua localizacao atual',
      'Ative o compartilhamento da sua localizacao em tempo real para continuar!',
    );
  }

  // _getLastKnowUserLocation() async {
    // position = await Geolocator()
        // .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    // if (position == null) _showLocatorDialog();
  // }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp || startWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  bool isValidUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    return (startWithHttp || startWithHttps);
  }

  Future<void> _saveForm() async {
    var isValid = _deviceFormKey.currentState.validate();

    if (!isValid) {
      return;
    }

    // await _getLastKnowUserLocation();

    // if (position == null && !kIsWeb) {
    //   return;
    // }

    _deviceFormKey.currentState.save();

    final deviceForm = Device(
      id: _deviceFormData['id'],
      deviceProperty: _deviceFormData['deviceProperty'],
      deviceTitle: _deviceFormData['deviceTitle'],
      deviceAdress: _deviceFormData['deviceAdress'],
      deviceLat: '',//_deviceFormData['deviceLat'],
      deviceLon: '',//_deviceFormData['deviceLon'],
      deviceTriggerUrl: _deviceFormData['deviceTriggerUrl'],
      deviceImage: {
        "deviceImageUrl": 'url',
        "deviceImageHeight": 1,
        "deviceImageWidth": 1,
      },
      deviceUsers: _deviceFormData['deviceUsers'],
      deviceManagers: _deviceFormData['deviceManagers'],
      deviceVerified: _deviceFormData['deviceVerified'],
    );

    setState(() {
      _deviceIsLoading = true;
    });

    try {
      if (_deviceFormData['id'] == null) {
        await DevicesCollection().deviceInsert(deviceForm);
      } else {
        await DevicesCollection().deviceUpdate(deviceForm);
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

  void _searching(bool enable) {
    setState(() {
      _isLoading = enable;
      _enableField = !enable;
    });
  }

  Future _searchByCep() async {
    _searching(true);
    await ViaCepService.fetchCep(cep: _searchByCepController.text)
        .then((result) {
      var complemento = result.complemento == null ? '' : result.complemento;
      setState(() {
        _adressResult = 'CEP: ' +
            result.cep +
            '.\nLogradouro: ' +
            result.logradouro +
            '.\nBairro: ' +
            result.bairro +
            '.\nComplemento: ' +
            complemento +
            '\nLocalidade: ' +
            result.localidade +
            '.\nUF: ' +
            result.uf +
            '.';
      });
      _searching(false);
    }).catchError((onError) {
      showFlushbar(
        context,
        'CEP Não existe...',
        'Digite novamente!',
      );
      _searching(false);
    });
  }

  final ImagePicker _picker = ImagePicker();
  File _profileImage;
  dynamic _decodedProfileImage;
  bool _uploadingImage = false;

  Future _getImage(String sourceImagem) async {
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
        toolbarColor: Colors.deepOrange,
        toolbarTitle: "RPS Cropper",
        statusBarColor: Colors.deepOrange.shade900,
        backgroundColor: Colors.white,
      ),
    );

    setState(() {
      _profileImage = File(cropped.path); //selectedImage.path);
      if (_profileImage != null) {
        _uploadingImage = true;
        _uploadFileFirestoreInstance(sourceImagem);
      }
    });
  }

  File _selectedFile;
  bool _inProcess = false;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
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

  Future _uploadFileFirestoreInstance(String sourceImagem) async {
    final archive = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('user_devices_image') //isso
        .child(widget.device.id + '.jpg');

    UploadTask task = archive.putFile(_profileImage);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      double _progress =
          snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble();
      print(_progress.toString() + '1');
      if (_progress < 1) {
        setState(() {
          _uploadingImage = true;
        });
      } else {
        if (sourceImagem == 'camera') {
          Timer(const Duration(milliseconds: 4500), () {
            setState(() {
              _uploadingImage = false;
            });
          });
        } else {
          Timer(const Duration(milliseconds: 2000), () {
            setState(() {
              _uploadingImage = false;
            });
          });
        }
      }
      print(_progress.toString() + '2');
    });

    task.whenComplete(() {
      _updatedeviceImage(task);
    });
  }

  _updatedeviceImage(dynamic task) async {
    var url = await (await task).ref.getDownloadURL();
    _decodedProfileImage =
        await decodeImageFromList(_profileImage.readAsBytesSync());
    deviceUpdateImage(widget.device.id, url, _decodedProfileImage)
        .then((value) {
      setState(() {
        _imageUrlRecovered = url;
      });
    });
  }

  Future<void> deviceUpdateImage(deviceId, url, decodedProfileImage) async {
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('$deviceId')
        .update({
      "deviceImage": {
        "deviceImageUrl": url,
        "deviceImageHeight": decodedProfileImage.height,
        "deviceImageWidth": decodedProfileImage.width,
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
          "C H A V E",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Astronaut_PersonalUse',
            color: AppColors.astronautCanvasColor,
          ),
        ),
        actions: <Widget>[
          widget.device != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Excluir Chave'),
                        content: Text('Tem certeza?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: Text('Sim'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    ).then(
                      (value) async {
                        if (value) {
                          try {
                            await DevicesCollection()
                                .deviceDelete(_deviceFormData['id']);
                            Navigator.of(context).pop();
                          } on HttpException catch (error) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                  icon: Icon(
                    MyFlutterApp.trash_1,
                  ),
                  iconSize: 22,
                  color: AppColors.accentColor,
                )
              : Container(),
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
                key: _deviceFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      widget.device == null || kIsWeb
                          ? Container()
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: FadeInImage(
                                    height: 220,
                                    width: (kIsWeb
                                        ? 400
                                        : MediaQuery.maybeOf(context)
                                            .size
                                            .width),
                                    placeholder:
                                        AssetImage('assets/logo/logo.png'),
                                    image: _imageUrlRecovered != ''
                                        ? NetworkImage(_imageUrlRecovered)
                                        : AssetImage('assets/logo/logo.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 220,
                                  child: Center(
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Container(
                                        child: _uploadingImage
                                            ? CircularProgressIndicator()
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.device == null || kIsWeb
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    _uploadingImage
                                        ? null
                                        : showModalBottomSheet(
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
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
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
                                                            Text('Apagar'),
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
                                                                _getImage(
                                                                    "camera");
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
                                                                _getImage(
                                                                    "gallery");
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
                                  color: AppColors.astratosDarkGreyColor,
                                  child: _uploadingImage
                                      ? Container(
                                          height: 15.0,
                                          width: 15.0,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          'Mudar Foto',
                                          style: TextStyle(
                                            color:
                                                AppColors.astronautCanvasColor,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                      TextFormField(
                        style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.accentColor,
                        ),
                        autofocus: true,
                        initialValue: _deviceFormData['deviceProperty'] != null
                            ? _deviceFormData['deviceProperty']
                            : '',
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.location_city,
                              color: AppColors.astratosDarkGreyColor),
                          hintText:
                              'EX: Edifício Via Paris, Condomínio Por do Sol, etc.',
                          labelText: 'Propriedade',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.astratosDarkGreyColor,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_deviceTitleFocusNode);
                        },
                        onSaved: (value) =>
                            _deviceFormData['deviceProperty'] = value,
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = value.trim().length < 3;
                          if (isEmpty || isInvalid) {
                            return 'Informe um Número válido com no mínimo 3 caracteres!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.accentColor,
                        ),
                        initialValue: _deviceFormData['deviceTitle'] != null
                            ? _deviceFormData['deviceTitle']
                            : '',
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search,
                              color: AppColors.astratosDarkGreyColor),
                          hintText:
                              'EX: Portaria B, Apto 511, Casa 12, Chácara 3, etc.',
                          labelText: 'Número',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.astratosDarkGreyColor,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _deviceTitleFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_deviceCepFocusNode);
                        },
                        onSaved: (value) =>
                            _deviceFormData['deviceTitle'] = value,
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = value.trim().length < 2;
                          if (isEmpty || isInvalid) {
                            return 'Informe um Número válido com no mínimo 2 caracteres!';
                          }
                          return null;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(
                              letterSpacing: 2,
                              color: AppColors.accentColor,
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            focusNode: _deviceCepFocusNode,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.location_on,
                                  color: AppColors.astratosDarkGreyColor),
                              hintText: 'EX: 7067432',
                              labelText: 'CEP',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            controller: _searchByCepController,
                            enabled: _enableField,
                          ),
                          RaisedButton(
                            onPressed: () {
                              _isLoading ? null : _searchByCep();
                            },
                            color: AppColors.astratosDarkGreyColor,
                            child: _isLoading
                                ? Container(
                                    height: 15.0,
                                    width: 15.0,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Consultar CEP',
                                    style: TextStyle(
                                      color: AppColors.astronautCanvasColor,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      TextFormField(
                        key: Key(_adressResult.toString()),
                        style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.accentColor,
                        ),
                        initialValue: _adressResult != null
                            ? _adressResult
                            : _deviceFormData['deviceAdress'],
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.map,
                              color: AppColors.astratosDarkGreyColor),
                          hintText: 'EX: SQFES 17 Bloco D apto 112',
                          labelText: 'Endereço',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.astratosDarkGreyColor,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        enabled: false,
                        focusNode: _deviceAdressFocusNode,
                        onSaved: (value) =>
                            _deviceFormData['deviceAdress'] = value,
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(height: 18),
                      widget.device == null
                          ? Container()
                          : Row(
                              children: [
                                Text(
                                  "U S U Á R I O S",
                                  style: TextStyle(
                                    color: AppColors.astratosDarkGreyColor,
                                    fontFamily: 'Astronaut_PersonalUse',
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(width: 16),
                                NeumorphicIcon(
                                  MyFlutterApp2.angle_double_right,
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: AppColors.astratosDarkGreyColor,
                                  ),
                                ),
                                SizedBox(width: 16),
                                NeumorphicText(
                                  '${widget.device.data()['deviceUsers'].length}',
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: AppColors.astratosDarkGreyColor,
                                  ),
                                  textStyle: NeumorphicTextStyle(
                                    fontFamily: 'Astronaut_PersonalUse',
                                    fontSize: 22,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                      widget.device == null ? Container() : SizedBox(height: 6),
                      widget.device == null
                          ? Container()
                          : Container(
                              width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context)
                                          .size
                                          .width) *
                                  0.93,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: streamUsersList(
                                    widget.device.data()['deviceUsers'],
                                    'users'),
                              ),
                            ),
                      widget.device == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         DeviceAddUsersPageList(
                                    //       widget.device.data(),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  color: AppColors.astratosDarkGreyColor,
                                  child: _uploadingImage
                                      ? Container(
                                          height: 15.0,
                                          width: 15.0,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          'Adicionar Usuarios',
                                          style: TextStyle(
                                            color:
                                                AppColors.astronautCanvasColor,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
