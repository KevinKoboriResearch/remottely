import 'package:url_launcher/url_launcher.dart';

void launchURL() async {
  const url =
      'https://www.canva.com/design/DAEUat-O5rQ/yYpsA_qXNmzTt41XKIFyvg/view?website#2:100-seguro';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
