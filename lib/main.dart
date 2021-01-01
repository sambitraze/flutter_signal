import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  DataState dataState;
  CallState callState;
  DataActivity dataActivity;
  String networkOperator;
  String operatorName;
  PhoneType type;
  String simOperator;
  String simOperatorName;
  SimState simState;
  bool isNetworkRoaming;
  List<SignalStrength> strength = [];
  bool loading = false;
  initPlatformState()async{
    setState(() {
      loading = true;
    });
    dataState = await telephony.cellularDataState;
    callState = await telephony.callState;
    dataActivity = await telephony.dataActivity;
    networkOperator = await telephony.networkOperator;
    operatorName = await telephony.networkOperatorName;
    type = await telephony.phoneType;
    simOperator = await telephony.simOperator;
    simOperatorName = await telephony.simOperatorName;
    simState = await telephony.simState;
    isNetworkRoaming = await telephony.isNetworkRoaming;
    strength = await telephony.signalStrengths;
    setState(() {
      loading = false;
    });
  }
  final Telephony telephony = Telephony.instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loading ?  Center(child: CircularProgressIndicator(),):Scaffold(
        appBar: AppBar(
          title: Text(
              Platform.isAndroid ? 'Android Device Info' : 'iOS Device Info'),
        ),
        body: ListView(
          children: [
            Text(dataState.toString()),
            Text(callState.toString()),
            Text(dataActivity.toString()),
            Text(networkOperator.toString()),
            Text(operatorName.toString()),
            Text(type.toString()),
            Text(simOperator.toString()),
            Text(simOperatorName.toString()),
            // Text(simState.toString()),
            // Text(isNetworkRoaming.toString()),
            Text(strength.toString()),
          ]
        ),
      ),
    );
  }
}
