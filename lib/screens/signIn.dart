
import 'package:activstar/api/signApi.dart';
import 'package:activstar/constants/constants.dart';
import 'package:activstar/screens/BottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class signIn extends StatefulWidget {
  const signIn({Key ,key}) : super(key: key);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    emailController.text = "";
    passwordController.text = "";
    super.initState();
  }


  Future<bool> onWillPop() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Form(
            key: globalFormKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:20.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.2,
                                  width:170,
                                  decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png')
                                  )
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child:Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE5E5E5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x1A000000),
                                          blurRadius: 30,
                                          offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextFormField(
                                        validator:  (String? value) {
                                          return null;
                                        },
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                              fontFamily: 'SFProDisplay',
                                              color: Colors.white,
                                              fontSize: 16,)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  height:60,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE5E5E5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x1A000000),
                                          blurRadius: 30,
                                          offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextFormField(
                                        controller: passwordController,
                                        validator: (String? value) {
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Heslo",
                                            hintStyle: TextStyle(
                                              fontFamily: 'SFProDisplay',
                                              color: Colors.white,
                                              fontSize: 16,)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40,),
                                InkWell(
                                  onTap: () async{
                                     SharedPreferences preferences = await SharedPreferences.getInstance();
                                    if(validateForm()) {
                                      signApi api=new signApi();
                                      api.login(context: context,emaill: emailController.text,password:passwordController.text ).then((value){
                                   if(value==true){
                                     print("Login Access Token" + preferences.getString('access_token').toString());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) =>bottomNavigationBar(1)),
                                    );
        
                                   }  
                                      });
                                    }
                                  
                                  },
                                  child: Container(
                                    width: 145,
                                    height: 40,
                                    decoration: BoxDecoration(  
                                        color: Color(0xFFDEC13C),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                      child: Text(
                                        "PRIHLÁSIŤ SA",
                                        style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
        
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.35,),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nemáte ešte konto?"),
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse("https://www.activstar.eu/register"),
                                  mode: LaunchMode.externalApplication
                                  );  
                              },
                              child: Text(
                                " Zaregistrujte sa teraz",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )]),
                    )
        
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool validateForm() {
    final form = globalFormKey.currentState;  
    if (form!.validate()) {
      return true;
    }
    return false;
  }

}
