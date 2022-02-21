import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_aes/flutter_aes.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String pkcs5Progress;

    //string format
    var data = "C88F076C49BC8E62074693ED3CE751B4";

    //create 16 byte random key
    var key = await FlutterAes.generateDesKey(128);

    print(key);
    //encrypt
    var encryptText = await FlutterAes.encryptString(data, key);

    print(encryptText);
    //decrypt
    var decryptText = await FlutterAes.decryptString(encryptText, key);

    print(decryptText);


    //encrypt
    var encryptCBCText = await FlutterAes.encryptString(data, "96C0BD57660729AB607993237E2CCF4A",iv:"ly202202140000yl");

    print(encryptCBCText);
    //decrypt
    var decryptCBCText = await FlutterAes.decryptString(encryptCBCText, "96C0BD57660729AB607993237E2CCF4A",iv:"ly202202140000yl");

    print(decryptCBCText);

    pkcs5Progress = "data1:" +
        data +
        "\n" +
        "create key:" +
        key +
        "\n" +
        "encryptText :" +
        encryptText +
        "\n" +
        "decryptText :" +
        decryptText +
        "\n"+
        "encryptCBCText :" +
        encryptCBCText +
        "\n"+
        "decryptCBCText :" +
        decryptCBCText +
        "\n";

    print(pkcs5Progress);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = pkcs5Progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_aes'),
        ),
        body: Center(
          child: Text('pkcs5Progress:\n $_platformVersion\n'),
        ),
      ),
    );
  }
}
