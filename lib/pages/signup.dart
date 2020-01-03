import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karigari/HomePage.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String gender="Male";
  String groupvalue = "Male";
  bool hidePass = true;
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpeg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/lg.png',
                width: 280.0,
                height: 240.0,
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        // ====================== First Name ======================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _firstnameTextController,
                                decoration: InputDecoration(
                                  hintText: "First name",
                                  icon: Icon(Icons.person_outline),
                                ),
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
                        // ====================== Last Name ====================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _lastnameTextController,
                                decoration: InputDecoration(
                                  hintText: "Last name",
                                  icon: Icon(Icons.person_outline),
                                ),
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
                        // ====================== Email ======================
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
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
                        // ====================== Password ======================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                  setState(() {
                                    hidePass= false;
                                  });
                                }),
                              ),
                            ),
                          ),
                        ),

                        // ====================== Confirm Password ======================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                      hintText: "Confirm password",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "The password has to be at least 6 characters long";
                                    } else if (_passwordTextController.text != value){
                                      return "The passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                  setState(() {
                                    hidePass= false;
                                  });
                                }),
                              ),
                            ),
                          ),
                        ),

                        // ====================== Gender ======================
                       Padding(
                         padding:
                         const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                         child: new Container(
                            color: Colors.white.withOpacity(0.4),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: ListTile(
                                        title: Text("Male",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: Colors.white),
                                        )
                                        ,trailing: Radio(
                                      value: "Male",groupValue: groupvalue,
                                      onChanged: (e)=>valueChanged(e),)
                                    )
                                ),

                                Expanded(
                                    child: ListTile(
                                        title: Text("Female",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: Colors.white),
                                        )
                                        ,trailing: Radio(
                                      value: "Female",groupValue: groupvalue,
                                      onChanged: (e)=>valueChanged(e),)
                                    )
                                )
                              ],
                            ),
                          ),
                       ),

                        // ====================== Phone Number ======================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Phone number",
                                  icon: Icon(Icons.phone),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The Phone number field cannot be empty";
                                  }else if(value.length !=10){
                                    return "Phone number should be of 10 digits";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        // =================== DOB ===================

                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Text("Yo",style: TextStyle(color: Colors.white),),
                        ),



                        // ====================== REGISTRATION BUTTON ======================
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blue.shade700,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async{
                                  validateForm();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Register",
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
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Text("Login",textAlign: TextAlign.center, style: TextStyle(color: Colors.red),))
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "Male"){
        groupvalue=e;
        gender=e;
      }else if(e =="Female"){
        groupvalue=e;
        gender=e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;


    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();


      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
            .then(
              (user) => Firestore.instance.collection("users").add({
                "First Name": _firstnameTextController.text,
                "Last Name": _lastnameTextController.text,
                "email": _emailTextController.text,
                "userId": user.user.uid,
                "phone":   _phoneNumberController.text,
                "gender": gender,
                "username": _firstnameTextController.text + " " + _lastnameTextController.text,
          }),
        )
            .catchError(
              (err) => print(
            err.toString(),
          ),
        );


        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName(HomePage().toString()));
      } else {
        print("already a user");
      }
    }
  }
}
  /*
  Future validateForm() async{
    FormState formState = _formKey.currentState;

    if(formState.validate()){
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null){
        firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text).then((user) => {

              _userServices.createUser(
                  {
                  "username": _nameTextController.text,
                  "email": _emailTextController.text,
                  "userId": user.user.uid,
                  "gender": gender,
              }
              )
        }).catchError((err)=>print(err.toString()));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }*/
