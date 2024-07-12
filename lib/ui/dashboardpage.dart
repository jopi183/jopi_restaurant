import 'package:flutter/material.dart';
import 'package:jopi_restaurant/ui/loginpage.dart';
class DashboardPage extends StatelessWidget{
  static const routeName = '/dashboard';
  const DashboardPage ({Key?key}): super(key: key);

  @override
  Widget build(BuildContext  context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
              children: <Widget>[
                Image.asset('images/resto.jpeg'),
                Positioned(
                  top: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                    child: Text('Login'),
                  ),
                )
            ],
          ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'JoPi Restaurant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                child: const Text(
                  'Aplikasi ini  menawarkan informasi lengkap tentang berbagai restoran. Dengan koleksi banyak restoran, aplikasi ini memudahkan pengguna untuk menemukan tempat makan terbaik di kota. Setiap restoran dilengkapi dengan detail menu, lokasi, ulasan, dan rating dari pengguna lainnya. Pengguna dapat mencari restoran berdasarkan kategori, jenis masakan, atau rating.  Nikmati kemudahan dalam menemukan pengalaman kuliner terbaik dengan aplikasi ini!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18.0),
                child: const Text(
                  'Mau makan apa hari ini?:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/tes1.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/tes2.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/tes3.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/tes4.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/tes5.jpeg'),
              ),
            ],
          ),
        ),
          ],
          ),
        ),
      ),
    );
  }
}