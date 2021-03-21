import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class FriendshipCollection {
  final auth = FirebaseAuth.instance;

  Future<void> friendshipRequestSet(requestUser, String result) async {
    final dateTime = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .doc('${requestUser.id}')
        .get()
        .then(
      (doc) async {
        if (doc.exists && result == 'sent') {
          return;
        } else if (result == 'sent') {
          await FirebaseFirestore.instance
              .collection('users')
              .doc('${auth.currentUser.uid}')
              .collection('userFriendships')
              .doc('${requestUser.id}')
              .set(
            {
              'contactDateTime': dateTime.toIso8601String(),
              'userId': requestUser.id,
              'status': result,
            },
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc('${requestUser.id}')
              .collection('userFriendships')
              .doc('${auth.currentUser.uid}')
              .set(
            {
              'contactDateTime': dateTime.toIso8601String(),
              'userId': auth.currentUser.uid,
              'status': 'arrived',
            },
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc('${auth.currentUser.uid}')
              .collection('userNotifications')
              .add(
            {
              'userNotificationType': 'friendshipSent',
              'userNotificationDateTime': dateTime.toIso8601String(),
              'userNotificationTitle': 'Requisição de amizade!"',
              'userNotificationDesc':
                  'Requisição enviada para "${requestUser['userName']}"\nemail: "${requestUser['userEmail']}"',
              'userNotificationObs': auth.currentUser.uid,
            },
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc('${requestUser.id}')
              .collection('userNotifications')
              .add(
            {
              'userNotificationType': 'friendshipArrived',
              'userNotificationDateTime': dateTime.toIso8601String(),
              'userNotificationTitle': 'Requisição de amizade!"',
              'userNotificationDesc':
                  'Requisição solicitada por "${auth.currentUser.displayName}"\nemail: "${auth.currentUser.email}"',
              'userNotificationObs': auth.currentUser.uid,
            },
          );
        } else {
          if (result == 'removed') {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${auth.currentUser.uid}')
                .collection('userFriendships')
                .doc('${requestUser.id}')
                .delete();
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${requestUser.id}')
                .collection('userFriendships')
                .doc('${auth.currentUser.uid}')
                .delete();
          } else {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${auth.currentUser.uid}')
                .collection('userFriendships')
                .doc('${requestUser.id}')
                .set(
              {
                'contactDateTime': dateTime.toIso8601String(),
                'userId': requestUser.id,
                'status': result,
              },
            );
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${requestUser.id}')
                .collection('userFriendships')
                .doc('${auth.currentUser.uid}')
                .set(
              {
                'contactDateTime': dateTime.toIso8601String(),
                'userId': auth.currentUser.uid,
                'status': result == 'blocked' ? 'dangerous' : result,
              },
            );
            if (result == 'accepted') {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('${requestUser.id}')
                  .collection('userNotifications')
                  .add(
                {
                  'userNotificationType': 'friendshipAccepted',
                  'userNotificationDateTime': dateTime.toIso8601String(),
                  'userNotificationTitle': 'Requisição de amizade!"',
                  'userNotificationDesc':
                      'Requisição aceita por "${auth.currentUser.displayName}"\nemail: "${auth.currentUser.email}"',
                  'userNotificationObs': auth.currentUser.uid,
                },
              );
            }
          }
        }
      },
    );
  }

  Future<List<String>> friendsList() async {
    var friends = [auth.currentUser.uid];
    var list = await FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .get();
    list.docs.forEach((element) {
      friends.add(element.id);
    });
    return friends;
  }

  Future<QuerySnapshot> userFriendshipsSearchSnapshots() async {
    var friends2 = await friendsList();
    return FirebaseFirestore.instance
        .collection('users')
        .where("userId", whereNotIn: friends2)
        .get();
  }

  Stream<QuerySnapshot> userFriendshipsSentSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .where("status", isEqualTo: 'sent')
        .snapshots();
  }

  Stream<QuerySnapshot> userFriendshipsArrivedSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .where("status", isEqualTo: 'arrived')
        .snapshots();
  }

  Stream<QuerySnapshot> userFriendshipsAcceptedSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .where("status", isEqualTo: 'accepted')
        .snapshots();
  }

  Stream<QuerySnapshot> userFriendshipsBlockedSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .where("status", isEqualTo: 'blocked')
        .snapshots();
  }
}
