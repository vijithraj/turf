import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/Design_pages/home_page.dart';
import 'package:turf_booking_app/Design_pages/register_page.dart';
import 'package:turf_booking_app/services/login_services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController PasswordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/turf images2.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: const InputDecoration(
                            labelText: " UserName",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.zero),
                            )),
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {},
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                        controller: PasswordController,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.zero),
                            )),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?",style: TextStyle(
                            fontSize: 16,color: Colors.white
                          ),),
                          TextButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Register()));
                          }, child: const Text("Sign up",style:
                            TextStyle(fontSize: 20,color: Colors.white),))



                        ],
                      ),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                            child: Text("Sign up"),
                            onPressed: () {
                              LoginServices().login(context: context, username: usernameController.text,
                                  password: PasswordController.text);
                              /*Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Home()));*/
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );

                                style:
                                ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ));
                              }
                            }),
                      ),

                    ],
                  ),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}
