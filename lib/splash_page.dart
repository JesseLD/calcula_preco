import 'dart:async';
import 'package:calcula_preco/shortcut0.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => shortcut0()));
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 220),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
