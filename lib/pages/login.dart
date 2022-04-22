
import 'package:flutter/cupertino.dart';
import 'package:gamersmultiverse/provider/user_provider.dart';
import 'package:gamersmultiverse/pages/signup.dart';
import 'package:gamersmultiverse/commons/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//This is the login page
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool hidePass=true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      //If the user is already logged in then the user will directly go to the home screen
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Image.asset(
                  'images/ultra_pcbuilds-23032021-0002.jpg',
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                  width:MediaQuery.of(context).size.width,
                ),

                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(16),

                      ),
                      child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[


                          SizedBox(height: 30,),
                               Container(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'images/LOGO-WEB-GG.png',
                                      color: Colors.white,
                                      width: 260.0,
                                    )),

                              SizedBox(height: 80,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.9),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _email,
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                      decoration: InputDecoration(

                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                        color: Colors.grey.shade800
                                        ),
                                        icon: Icon(Icons.alternate_email,color:Colors.grey.shade800,),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.9),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: ListTile(
                                      title: TextFormField(
                                        controller: _password,
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                        obscureText: hidePass,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color:Colors.grey.shade800
                                            ),
                                            icon: Icon(Icons.lock_outline,color: Colors.grey.shade800,),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "The password field cannot be empty";
                                          } else if (value.length < 6) {
                                            return "the password has to be at least 6 characters long";
                                          }
                                          return null;
                                        },
                                      ),
                                      trailing: IconButton(
                                          icon: Icon(Icons.remove_red_eye,color: Colors.grey.shade800),
                                          onPressed: () {
                                            setState(() {
                                              hidePass = !hidePass;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black,
                                    elevation: 0.0,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          if (!await user.signIn(
                                              _email.text, _password.text))
                                            _key.currentState.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Sign in failed")));
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Forgot password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUp()));
                                          },
                                          child: Text(
                                            "Create an account",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                fontSize: 17),
                                          ))),
                                ],
                              ),

                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
