import 'package:CUValles/widgets/cardtextfield.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Login extends StatefulWidget {

  @override
  LoginState createState() => LoginState();

}

class LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController code = TextEditingController();
  TextEditingController nip = TextEditingController();
  bool codeError = false, nipError = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: PRIMARY_COLOR,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.only(
          left: 32,
          right: 32
        ),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (MediaQuery.of(context).viewInsets.bottom == 0) ? 
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery.of(context).size.width-170,
                  ),
              ): Container(),
              CardTextField(
                controller: code,
                icon: Icon(Icons.account_circle),
                obscureText: false,
                hintText: "Código",
                eye: false,
                error: codeError,
              ),
              CardTextField(
                controller: nip,
                icon: Icon(MdiIcons.key),
                obscureText: true,
                eye: true,
                hintText: "NIP",
                error: nipError,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                  child: Text(
                    "Olvidé mi contraseña",
                    style: TextStyle(
                      color: ACCENT_COLOR,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  onTap: () {
                    launch("http://siiauescolar.siiau.udg.mx/wus/bansaturn.ggpnip.codigo_ventana");
                  },
                )
              ),
              MaterialButton(
                color: ACCENT_COLOR,
                onPressed: () {
                  if (code.text.isNotEmpty && nip.text.isNotEmpty) {
                    _scaffoldkey.currentState.showSnackBar(
                      SnackBar(content: Text("Zi."))
                    );
                  } else {
                    _scaffoldkey.currentState.showSnackBar(
                      SnackBar(content: Text("Ha dejado campos vacíos."))
                    );
                  }
                  setState(() {
                    codeError = code.text.isEmpty;
                    nipError = nip.text.isEmpty;
                  });
                },
                child: Text(
                  "INGRESAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}