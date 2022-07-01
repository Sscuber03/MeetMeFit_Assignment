import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meetmefit_assignment/net/flutterfire.dart';
import 'package:meetmefit_assignment/showprofile/showprofile.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  TextEditingController _nameField = TextEditingController();
  TextEditingController _aboutField = TextEditingController();

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            child: Text(
              "MeetMeFit",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    height: 200,
                    width: 200,
                    child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        picUpload();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add_a_photo),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    fileNameStore,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: _nameField,
                      decoration: InputDecoration(
                        hintText: "name",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _aboutField,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "about....",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        labelText: "About....",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        bool shouldNavigate = await createProfile(
                            _nameField.text, _aboutField.text);
                        if (shouldNavigate) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProfile(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
