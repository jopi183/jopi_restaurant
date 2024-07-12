import 'package:flutter/material.dart';
import 'package:jopi_restaurant/ui/mainpage.dart';
class LoginPage extends StatefulWidget{
  static const routeName = '/login';
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<LoginPage>{
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _username,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(25.0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: (){
                  String username = _username.text;
                  Navigator.pushNamed(context, MainPage.routeName,arguments: username);
                },
                child: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}