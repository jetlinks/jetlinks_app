import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jetlinks_app/utils/base64.dart';

class WallPagerPage extends StatefulWidget {
  final String wallpaperImageUrl;
  WallPagerPage({this.wallpaperImageUrl});
  @override
  _WallPagerPageState createState() => _WallPagerPageState(wallpaperImageUrl);
}

class _WallPagerPageState extends State<WallPagerPage> {

  String wallPaperImageUrl;

  _WallPagerPageState(String wallPaperImageUrl){
    this.wallPaperImageUrl=Base64.decodeBase64(wallPaperImageUrl.replaceAll("/", '/'));
  }

  double _top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: GestureDetector(
          child: ExtendedImage.network(wallPaperImageUrl,cache: true,fit: BoxFit.cover,),
          onVerticalDragUpdate: (DragUpdateDetails details){
            _top+=details.delta.dy;
          },
          onVerticalDragDown: (DragDownDetails details){
            _top=0;
          },
          onVerticalDragEnd: (DragEndDetails details){
            if(details.velocity.pixelsPerSecond.dy<0&&_top<=-150){
//              NavigatorU
            }
          },
        ),
      ),
    );
  }
}
