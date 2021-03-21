import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:io';

class UserPerfilPageDesc extends StatefulWidget {
  final AsyncSnapshot<DocumentSnapshot> userSnapshot;
  UserPerfilPageDesc(this.userSnapshot);

  @override
  _UserPerfilPageDescState createState() => _UserPerfilPageDescState();
}

class _UserPerfilPageDescState extends State<UserPerfilPageDesc> {
  final ImagePicker _picker = ImagePicker();
  File _profileImage;
  dynamic _decodedProfileImage;
  bool _uploadingImage = false;
  var auth = FirebaseAuth.instance;

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

    setState(() {
      _profileImage = File(selectedImage.path);
      if (_profileImage != null) {
        _uploadingImage = true;
        _uploadFileFirestoreInstance(sourceImagem);
      }
    });
  }

  Future _uploadFileFirestoreInstance(String sourceImagem) async {
    final archive = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('user_profile_image') //isso
        .child(widget.userSnapshot.data['userId'] + '.jpg');

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
      _updateUserImageProfile(task);
    });
  }

  _updateUserImageProfile(dynamic task) async {
    var url = await(await task).ref.getDownloadURL();
    auth.currentUser.updateProfile(
      photoURL: url,
    );
    _decodedProfileImage =
        await decodeImageFromList(_profileImage.readAsBytesSync());
    FirebaseFirestore.instance.collection("users").doc(widget.userSnapshot.data['userId']).update({
      "userImageProfile": {
        "userImageProfileUrl": url,
        "userImageProfileHeight": _decodedProfileImage.height,
        "userImageProfileWidth": _decodedProfileImage.width,
      }
    });
  }

// _localStorageUserImageProfile(dynamic task) async {
//   Bitmap realImage = BitmapFactory.decodeStream(stream);
// ByteArrayOutputStream baos = new ByteArrayOutputStream();
// realImage.compress(Bitmap.CompressFormat.JPEG, 100, baos);   
// byte[] b = baos.toByteArray(); 

// String encodedImage = Base64.encodeToString(b, Base64.DEFAULT);
// textEncode.setText(encodedImage);

// SharedPreferences shre = PreferenceManager.getDefaultSharedPreferences(this);
// Editor edit=shre.edit();
// edit.putString("image_data",encodedImage);
// edit.commit();
// }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              kIsWeb
                  ? Stack(
                      children: [
                        CircleAvatar(
                          radius: 86,
                          backgroundColor: AppColors.astratosDarkGreyColor,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: widget.userSnapshot
                                        .data['userImageProfile']['userImageProfileUrl'] !=
                                    null
                                ? NetworkImage(widget.userSnapshot
                                    .data['userImageProfile']['userImageProfileUrl'])
                                : null,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        CircleAvatar(
                          radius: 86,
                          backgroundColor: AppColors.astratosDarkGreyColor,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: widget.userSnapshot
                                        .data['userImageProfile']['userImageProfileUrl'] !=
                                    null
                                ? NetworkImage(widget.userSnapshot
                                    .data['userImageProfile']['userImageProfileUrl'])
                                : null,
                          ),
                        ),
                        Container(
                          height: 172,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              height: 172,
                              child: _uploadingImage
                                  ? CircularProgressIndicator()
                                  : Container(),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 45,
                          left: 45,
                          child: widget.userSnapshot.data['userImageProfile']
                                      ['userImageProfileUrl'] !=
                                  null
                              ? Container()
                              : NeumorphicIcon(
                                  MyFlutterApp.user_4,
                                  size: 80,
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: InkWell(
                            onTap: () {
                              _getImage("gallery");
                            },
                            child: NeumorphicIcon(
                              MyFlutterApp2.picture,
                              size: 40,
                              style: NeumorphicStyle(
                                depth: 1,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _getImage("camera");
                            },
                            child: NeumorphicIcon(
                              MyFlutterApp2.camera,
                              size: 40,
                              style: NeumorphicStyle(
                                depth: 1,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 48,
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 8),
              //   child: TextField(
              //     controller: _controllerNome,
              //     autofocus: true,
              //     keyboardType: TextInputType.text,
              //     style: TextStyle(fontSize: 20),
              //     onChanged: (texto){
              //       _atualizarNumeroFiresbase(texto);
              //     },
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              //         hintText: "Número de Telefone",
              //         filled: true,
              //         fillColor: Colors.white,
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(32))),
              //   ),
              // ),
              Row(children: [
                IconButton(
                  icon: Icon(MyFlutterApp.user_4),
                  color: AppColors.astratosDarkGreyColor,
                  onPressed: () {
                    _getImage("galeria");
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome",
                        style: TextStyle(
                          color: AppColors.astratosDarkGreyColor,
                          fontFamily: 'Astronaut_PersonalUse',
                          letterSpacing: 4,
                          wordSpacing: 3,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.userSnapshot
                            .data['userDisplayName'], //auth.currentUser.displayName,
                        style: TextStyle(
                          fontFamily: 'Astronaut_PersonalUse',
                          color: AppColors.accentColor,
                          letterSpacing: 1,
                          wordSpacing: 3,
                          fontSize: 18,
                        ),
                      ),
                    ]),
              ]),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey[300],
                height: 10,
                thickness: 1,
                indent: 66,
                endIndent: 0,
              ),
              SizedBox(height: 10),
              Row(children: [
                IconButton(
                  icon: Icon(Icons.mail),
                  color: AppColors.astratosDarkGreyColor,
                  onPressed: () {
                    _getImage("galeria");
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail",
                        style: TextStyle(
                          color: AppColors.astratosDarkGreyColor,
                          fontFamily: 'Astronaut_PersonalUse',
                          letterSpacing: 4,
                          wordSpacing: 3,
                          fontSize: 14,
                        ),
                      ),
                      // SizedBox(height: 6),
                      Text(
                        widget.userSnapshot
                            .data['userEmail'], //auth.currentUser.email,
                        style: TextStyle(
                          fontFamily: 'Astronaut_PersonalUse',
                          color: AppColors.accentColor,
                          letterSpacing: 1,
                          wordSpacing: 3,
                          fontSize: 18,
                        ),
                      ),
                    ]),
              ]),
              SizedBox(height: 6),
              Divider(
                color: Colors.grey[300],
                height: 10,
                thickness: 1,
                indent: 66,
                endIndent: 0,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    color: AppColors.astratosDarkGreyColor,
                    onPressed: () {
                      _getImage("galeria");
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telefone",
                        style: TextStyle(
                          color: AppColors.astratosDarkGreyColor,
                          fontFamily: 'Astronaut_PersonalUse',
                          letterSpacing: 4,
                          wordSpacing: 3,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.userSnapshot
                            .data['userPhoneNumber'], // auth.currentUser.displayName,
                        style: TextStyle(
                          fontFamily: 'Astronaut_PersonalUse',
                          color: AppColors.accentColor,
                          letterSpacing: 1,
                          wordSpacing: 3,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
