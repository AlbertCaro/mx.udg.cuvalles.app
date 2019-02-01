import 'package:CUValles/values/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({this.title, this.imageUrl, this.content, this.hasContentTitle = false, this.contentTitle = "", this.contentSubtitle = ""});
  final String title, imageUrl, contentTitle, contentSubtitle;
  final List<Widget> content;
  final bool hasContentTitle;

  @override
  Widget build(BuildContext context) {
    
    return CustomScrollView(
      slivers: <Widget>[
        Device.get().isPhone ?
        SliverAppBar(
          expandedHeight: 256.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              padding: EdgeInsets.only(right: 112),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            background: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ) : SliverList(delegate: SliverChildListDelegate([]),),
        hasContentTitle ?
        SliverList(delegate: SliverChildListDelegate([
          Container(
            color: ACCENT_COLOR,
            padding: EdgeInsets.all(Device.get().isPhone ? 16 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Container(
                    child: Text(
                      contentTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Device.get().isTablet && contentSubtitle != "" ?
                Text(
                  contentSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70
                  ),
                ) : Container()
              ],
            ),
          )
        ]),) : SliverList(delegate: SliverChildListDelegate([]),),
        SliverList(
          delegate: SliverChildListDelegate(content),
        )
      ],
    );
  }

}