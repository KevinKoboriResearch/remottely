import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:remottely/data/firestore/device_triggered_collection.dart';
import 'package:remottely/functions/authenticate.dart';

deviceKeyDialog(BuildContext context, dynamic device) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Tem certeza?',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Text(
        'O dispositivo está a 1.373m de distancia.',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Theme.of(ctx).accentColor,
          child: Text('NÃO ABRIR'),
          onPressed: () {
            Navigator.of(ctx).pop();
            showFlushbar(
              context,
              'A B E R T U R A   C A N C E L A D A',
              'Ação cancelada por você!',
            );
          },
        ),
        FlatButton(
          child: Text('ABRIR MESMO ASSIM'),
          textColor: Theme.of(ctx).accentColor,
          onPressed: () async {
            bool isAuthenticated = await authenticateUser(context);
            if (isAuthenticated) {
              bool keyTriggered = true; //await chamarDispositivoReal(context);
              if (keyTriggered) {
                await DeviceTriggered().deviceTriggeredInsert(device, 'device');
                Navigator.of(ctx).pop();
                showFlushbar(
                  context,
                  'A B E R T A',
                  'Porta "${device['deviceTitle'].toUpperCase()}" aberta com sucesso!',
                );
              } else {
                Navigator.of(ctx).pop();
                showFlushbar(
                  context,
                  'A B E R T U R A   N E G A D A',
                  'Abertura da Porta "${device['deviceTitle'].toUpperCase()}" negada!' +
                      '\nEsta chave possui distanciamento mínimo para ser aberta.' +
                      '\nEntre em contato com o gestor da CHAVE e verifique as regras de utilização da mesma!',
                );
              }
            }
          },
        ),
      ],
    ),
  );
}
