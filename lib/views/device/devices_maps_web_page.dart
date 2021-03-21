import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
class DevicesMapsWebPage extends StatefulWidget {
  @override
  DevicesMapsWebPageState createState() => DevicesMapsWebPageState();
}

class DevicesMapsWebPageState extends State<DevicesMapsWebPage> {
    @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pronto em breve para web, acesse pelo app mobile!',
            ),
            Text(
              'REMOTTELY KEY',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
