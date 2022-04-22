import 'package:gamersmultiverse/commons/common.dart';
import 'package:gamersmultiverse/provider/user_provider.dart';
import 'package:gamersmultiverse/commons/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
//This is the signup screen
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,

      body: user.status == Status.Authenticating ? Loading() : Stack(

          children: <Widget>[
            Image.asset(
              'images/signupbackground.jpg',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,

              width: MediaQuery.of(context).size.width,
            ),

      Padding(
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
    SizedBox(height: 40,),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
    alignment: Alignment.topCenter,
    child: Image.asset(
    'images/LOGO-WEB-GG.png',
    color: Colors.white,
    width: 260.0,
    )),
    ),
    Padding(
    padding:
    const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
    child: Material(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.grey.withOpacity(0.9),
    elevation: 0.0,
    child: Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: ListTile(
    title: TextFormField(
    controller: _name,
      style: TextStyle(
          color: Colors.black
      ),
    decoration: InputDecoration(
    hintText: "Full name",
    hintStyle: TextStyle(
      color:Colors.grey.shade800
    ),
    icon: Icon(Icons.person_outline,color: Colors.grey.shade800),
    border: InputBorder.none),
    validator: (value) {
    if (value.isEmpty) {
    return "The name field cannot be empty";
    }
    return null;
    },
    ),
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
    padding: const EdgeInsets.only(left: 12.0),
    child: ListTile(
    title: TextFormField(
    controller: _email,
      style: TextStyle(
          color: Colors.black
      ),
    decoration: InputDecoration(
    hintText: "Email",
        hintStyle: TextStyle(
            color:Colors.grey.shade800
        ),
    icon: Icon(Icons.alternate_email,color: Colors.grey.shade800),
    border: InputBorder.none),
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
    ),

    Padding(
    padding:
    const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
    child: Material(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.grey.withOpacity(0.9),
    elevation: 0.0,
    child: Padding(
    padding: const EdgeInsets.only(left: 12.0),
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
    padding:
    const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
    child: Material(
    borderRadius: BorderRadius.circular(20.0),
    color: Colors.black,
    elevation: 0.0,
    child: MaterialButton(
    onPressed: () async{
    if(_formKey.currentState.validate()){
    if(!await user.signUp(_name.text ,_email.text, _password.text)){
    _key.currentState.showSnackBar(SnackBar(content: Text("Sign up failed")));
    return;
    }
    changeScreenReplacement(context, HomePage());
    }
    },
    minWidth: MediaQuery.of(context).size.width,
    child: Text(
    "Sign up",
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0),
    ),
    )),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
    onTap: () {
    Navigator.pop(context);
    },
    child: Text(
    "I already have an account",
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white, fontSize: 17),
    ))),

    ],
    )),
      ),
      ),
          ],
      ),
    );
  }

}

