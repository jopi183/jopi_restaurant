import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: Text('Setting Page'),
      ),
    );
  }
}
