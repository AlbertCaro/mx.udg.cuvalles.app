import 'package:CUValles/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({this.onDetailPressed, this.user});
  
  Function onDetailPressed;
  User user;

  @override
  Widget build(BuildContext context) {

    return UserAccountsDrawerHeader(
      onDetailsPressed: onDetailPressed,
      decoration: BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/header.jpg"),
        ),
      ),
      accountName: Text( user != null ? user.name : 'No se ha iniciado sesión' ),
      accountEmail: Text( user != null ? user.career : 'Presione aquí para iniciar sesión' ),
      currentAccountPicture: user != null ? CircleAvatar(
        backgroundImage: CachedNetworkImageProvider("http://148.202.89.11/spec/Fotos/CARO%20NAVARRO%20ALBERTO.jpg"),
      ) : null,
    );
  }

}