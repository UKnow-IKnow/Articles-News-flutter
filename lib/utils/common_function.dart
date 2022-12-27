import 'package:cached_network_image/cached_network_image.dart';
import 'package:articles_news/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void teleport(BuildContext context, String screen) {
  Navigator.of(context).pushNamed(screen);
}

void teleportWithArguments(
    BuildContext context, String screen, Object arguments) {
  Navigator.of(context).pushNamed(screen, arguments: arguments);
}

circularProgress({
  double size = 20,
  Color color = black,
}) {
  // ignore: prefer_const_constructors
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color,
      ),
    ),
  );
}

myText(String content,
    {String fontfamily = "Roboto Slab",
    double size = 20,
    int maxLine = 3,
    Color? color = Colors.white,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    content,
    textScaleFactor: 1,
    overflow: TextOverflow.fade,
    maxLines: maxLine,
    //maxLines: 3,
    style: GoogleFonts.getFont(fontfamily,
        fontSize: size, color: color, fontWeight: fontWeight),
  );
}

mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

myCachedNetworkImage(String url, int type) {
  return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (context, url, error) => Container(),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: type == 0
                ? BorderRadius.circular(0)
                : type == 2
                    ? BorderRadius.circular(13)
                    : const BorderRadius.only(
                        topRight: Radius.circular(13),
                        bottomRight: Radius.circular(13)),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      placeholder: (context, url) => circularProgress());
}

Future<bool> waitABit() async {
  final time = await Future.delayed(const Duration(milliseconds: 300))
      .then((value) => DateTime.now());
  return true;
}

getToast(
  BuildContext context,
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: white,
      textColor: black,
      fontSize: 16.0);
}
