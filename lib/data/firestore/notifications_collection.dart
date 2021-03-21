import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:remottely/data/firestore/users_collection.dart';
class NotificationsCollection {
  final auth = FirebaseAuth.instance;

  Future<void> notificationDeviceTriggeredInsert(
      managers, notificationType, dateTime, device) async {
    // List<Widget> list = [];
    for (var i = 0; i < managers.length; i++) {
      if (managers[i] != '' && managers[i] != null) {
        // var UsersCollection().userGet('${managers[i]}');
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${managers[i]}')
            .collection('userNotifications')
            .add(
          {
            'userNotificationType': notificationType,
            'userNotificationDateTime': dateTime.toIso8601String(),
            'userNotificationTitle':
                'Porta "${device['deviceTitle']}"\nPropriedade: "${device['deviceProperty']}"',
            'userNotificationDesc':
                'Aberta por "${auth.currentUser.displayName}"',
            'userNotificationObs': auth.currentUser.uid,
          },
        );
      }
    }
  }

  Future<void> notificationRequestFriendshipInsert(
      managers, notificationType, dateTime, device) async {
    // List<Widget> list = [];
    for (var i = 0; i < managers.length; i++) {
      if (managers[i] != '' && managers[i] != null) {
        // var UsersCollection().userGet('${managers[i]}');
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${managers[i]}')
            .collection('userNotifications')
            .add(
          {
            'userNotificationType': notificationType,
            'userNotificationDateTime': dateTime.toIso8601String(),
            'userNotificationTitle':
                'Porta "${device['deviceTitle']}"\nPropriedade: "${device['deviceProperty']}"',
            'userNotificationDesc':
                'Aberta por "${auth.currentUser.displayName}"',
            'userNotificationObs': auth.currentUser.uid,
          },
        );
      }
    }
  }

  // Future<void> userNotificationDelete(deviceId) async {
  //   await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc('${auth.currentUser.uid}')
  //     .collection('userNotifications')
  //     // .doc('${auth.currentUser.uid}')
  //     .delete();
  // }

  Stream<QuerySnapshot> userNotificationSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userNotifications')
        // .orderBy('userNotificationDateTime')
        .snapshots();
  }
}
