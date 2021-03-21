import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/functions/get_initials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:remottely/exceptions/auth_exception.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form = GlobalKey();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  AnimationController _animatedController;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;
  bool _showPassword;
  String _errors = '';

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animatedController,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.8),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animatedController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animatedController.dispose();
    // CheckInternet().listener.cancel();
    super.dispose();
  }

  final Map<String, dynamic> _authData = {
    'userId': '',
    'userEmail': '',
    'userPassword': '',
    'userName': '',
    'userImageProfile': {
      'userImageProfileUrl': '',
      'userImageProfileHeight': '',
      'userImageProfileWidth': '',
    }, //'',
    'userVerified': null,
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro!'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    // CheckInternet().checkConnection(context);
    _form.currentState.validate();

    if (_errors != '') {
      //!_form.currentState.validate()) {
      showFlushbar(
        context,
        'ATENÇÃO!',
        '$_errors',
      );
      _errors = '';
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    UserCredential authResult;

    try {
      if (_authMode == AuthMode.Login) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: _authData["userEmail"].trim(),
          password: _authData["userPassword"],
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: _authData["userEmail"].trim(),
          password: _authData["userPassword"],
        );
        authResult.user.updateProfile(
          displayName: _authData["userName"],
        );
        _authData["userId"] = authResult.user.uid;
        _authData["userVerified"] = false;
        _authData.remove('userPassword');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(_authData);
        // final dateTime = DateTime.now();
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user.uid)
        //     .collection('userFriendships');
        //     .doc(authResult.user.uid)
        //     .set({
        //   'contactDateTime': dateTime.toIso8601String(),
        //   'status': 'me',
        // });
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(
          "Verifique se o email e a senha foram digitados corretamente.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animatedController.forward();
    } else {
      _form.currentState.reset();
      setState(() {
        _authMode = AuthMode.Login;
        // _refreshEmail = _authData["email"];
      });
      _animatedController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(flex: 11),
                // SizedBox(height: 86),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  // color: Colors.blue,
                  height: _authMode == AuthMode.Login ? 106 : 206, //193, 336
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        // initialValue: _emailController.text,//_refreshEmail != null ? _refreshEmail : null,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        cursorColor: AppColors.accentColor,
                        decoration: InputDecoration(
                          hintText: "E - M A I L",
                          hintStyle: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'Astronaut_PersonalUse',
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            _errors += '\nInforme um e-mail válido!';
                            return null;
                            // return "Informe um e-mail válido!";
                          }
                          return null;
                        },
                        onSaved: (value) => _authData['userEmail'] = value,
                      ),
                      TextFormField(
                        textInputAction: _authMode == AuthMode.Login
                            ? null
                            : TextInputAction.next,
                        textAlign: TextAlign.center,
                        cursorColor: AppColors.accentColor,
                        decoration: InputDecoration(
                          hintText: "S E N H A",
                          hintStyle: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'Astronaut_PersonalUse',
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        onFieldSubmitted: (_) {
                          _authMode == AuthMode.Login ? _submit() : null;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            _errors += '\nInforme uma senha válida!';
                            return null;
                            // return "Informe uma senha válida!";
                          }
                          return null;
                        },
                        onSaved: (value) => _authData['userPassword'] = value,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(flex: 15),
                // SizedBox(height: 190),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          cursorColor: AppColors.accentColor,
                          decoration: InputDecoration(
                            hintText: "C O N F I R M A R   S E N H A",
                            hintStyle: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: 'Astronaut_PersonalUse',
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                          ),
                          obscureText: !_showPassword,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    _errors += '\nSenha são diferentes!';
                                    return null;
                                    // return "Senha são diferentes!";
                                  } else if (value == '') {
                                    _errors += '\nInsira a senha novamente!';
                                    return null;
                                    // return "Insira a senha novamente";
                                  }
                                  return null;
                                }
                              : null,
                        ),
                        TextFormField(
                          textInputAction: _authMode == AuthMode.Login
                              ? null
                              : TextInputAction.next,
                          textAlign: TextAlign.center,
                          cursorColor: AppColors.accentColor,
                          decoration: InputDecoration(
                            hintText: "N O M E   C O M P L E T O",
                            hintStyle: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: 'Astronaut_PersonalUse',
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (_) {
                            _authMode == AuthMode.Login ? null : _submit();
                          },
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  var initials = getInitials(value);
                                  if (initials.length >= 2 &&
                                      value.length >= 7) {
                                    return null;
                                  }
                                  _errors += '\nInsira o seu nome completo!';
                                  return null;
                                  // return "Insira o seu nome completo!";
                                }
                              : null,
                          onSaved: _authMode == AuthMode.Signup
                              ? (value) => _authData['userName'] = value
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
            Positioned(
              bottom: 14,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text("Mostrar senha"),
                      value: _showPassword,
                      onChanged: (newValue) {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 32,
                        child: RaisedButton(
                          elevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          highlightElevation: 0,
                          disabledElevation: 0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: AppColors.textColor,
                            ),
                          ),
                          onPressed: () {
                            _submit();
                          },
                          child: Text(
                            "${_authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'}",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 32,
                      child: RaisedButton(
                        elevation: 0,
                        focusElevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        disabledElevation: 0,
                        color: AppColors.astratosGreyColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        onPressed: _switchAuthMode,
                        child: Text(
                          "${_authMode == AuthMode.Login ? 'NÃO TEM REGISTRO?' : 'JÁ POSSUI REGISTRO?'}",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
