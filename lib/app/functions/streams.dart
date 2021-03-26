// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:shop/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:shop/data/firestore/users_collection.dart';
// import 'dart:ui';
// import 'dart:convert';
// import 'package:firebase_admin/firebase_admin.dart';
// import 'package:firebase_admin/src/credential.dart';

// List streamUsersList(List<dynamic> usersList, listType) {
//   // testing();
//   List<Widget> list = [];
//   for (var i = 0; i < usersList.length; i++) {
//     // print('MEU DEUS DO CEEEU:' + usersList[i]);
//     if (usersList[i] != '' && usersList[i] != null) {
//       list.add(
//         StreamBuilder(
//           stream: UsersCollection().userSnapshots(usersList[i]),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Row(
//               children: [
//                 Text(
//                   snapshot.data["userName"] != null
//                       ? snapshot.data["userName"].toUpperCase()
//                       : 'não temos o nome do usuário',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: AppColors.accentColor,
//                     fontSize: 16,
//                   ),
//                 ),
//                 // Spacer(),
//                 listType == 'managers'
//                     ? Padding(
//                         padding: const EdgeInsets.only(left: 4.0),
//                         child: Icon(
//                           Icons.settings,
//                           color: AppColors.accentColor,
//                           size: 16,
//                         ),
//                       )
//                     : Container(),
//               ],
//             );
//           },
//         ),
//       );
//     } else {
//       list.add(
//         Text(
//           'usuário não existe*'.toUpperCase(),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             color: AppColors.redColor,
//             fontSize: 16,
//           ),
//         ),
//       );
//     }
//   }
//   return list;
// }
