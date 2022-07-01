import 'package:flutter/material.dart';
import 'package:meetmefit_assignment/createprofile/createprofile.dart';
import 'package:meetmefit_assignment/net/flutterfire.dart';
import 'package:meetmefit_assignment/showprofile/showprofile.dart';
import 'package:meetmefit_assignment/signup/signup.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/MeetMeFit Assignmentpic.jpg",
                fit: BoxFit.fitWidth,
                width: 200,
                height: 240,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: _emailField,
                  decoration: InputDecoration(
                    hintText: "something@gmail.com",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: _passwordField,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
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
                    bool shouldNavigate =
                        await logIn(_emailField.text, _passwordField.text);
                    bool exists = await checkExists();
                    if (shouldNavigate && exists==false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProfile(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProfile(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
