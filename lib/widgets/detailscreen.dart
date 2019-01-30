import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({this.title, this.imageUrl, this.content});
  final String title, imageUrl;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    
    return CustomScrollView(
      slivers: <Widget>[
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
        ),
        SliverList(
          delegate: SliverChildListDelegate(content),
        )
      ],
    );
  }

}