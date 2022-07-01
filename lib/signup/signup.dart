import 'package:flutter/material.dart';
import 'package:meetmefit_assignment/createprofile/createprofile.dart';
import 'package:meetmefit_assignment/login/login.dart';
import 'package:meetmefit_assignment/net/flutterfire.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _confirmPasswordField = TextEditingController();
  bool _isObscure = true;
  bool _isObscurecon = true;

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
                height: 20,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: _confirmPasswordField,
                  obscureText: _isObscurecon,
                  decoration: InputDecoration(
                    hintText: "confirm password",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscurecon ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscurecon = !_isObscurecon;
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
                    if(_passwordField.text != _confirmPasswordField.text){
                      print("Passwords don't match. Re enter password");
                    } else {
                      bool shouldNavigate = await signUp(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProfile(),),);
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
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
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "Log In",
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