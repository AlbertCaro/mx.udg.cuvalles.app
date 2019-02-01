import 'package:CUValles/widgets/cardtextfield.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_device_type/flutter_device_type.dart';


class Login extends StatefulWidget {

  @override
  LoginState createState() => LoginState();

}

final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: PRIMARY_COLOR,
      body: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover
          )
        ),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Logo(),
                  LoginForm(
                    center: false,
                  )
                ],
              ) : Row(
              children: <Widget>[
                Expanded(
                  child: Logo(),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(Device.get().isTablet ? 32 : 0),
                    child: LoginForm(
                      center: true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}

class Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return (MediaQuery.of(context).viewInsets.bottom == 0) ? 
      Padding(
        padding: EdgeInsets.only(bottom: Device.get().isTablet ? 64 : 16),
        child: Image.asset(
          "assets/images/logo.png",
          width: Device.get().isPhone ? 
          MediaQuery.of(context).size.width/2-50 : null,
        ),
      ): Container();
  }
  
}

class LoginForm extends StatefulWidget {
  final bool center;

  const LoginForm({Key key, this.center}) : super(key: key);

  @override
  LoginFormState createState() {
    return new LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  TextEditingController code = TextEditingController();

  TextEditingController nip = TextEditingController();

  bool codeError = false, nipError = false;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.only(
        right: Device.get().isTablet ? 64 : 0,
        left: Device.get().isTablet ? 64 : 0
      ),
      child: Column(
      mainAxisAlignment: widget.center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        CardTextField(
          controller: code,
          icon: Icon(Icons.account_circle),
          obscureText: false,
          hintText: "código",
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
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
    );
  }
}