import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Widget/Message/ToastMessage.dart';

///it written for check the internet
///it shows this message when we have not internet
Future<bool> checkInternet(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // when we have not internet
    showToastMessage(context, textMessage: 'Lütfen internet bağlantınızı kontrol ediniz.');
    return false;
  } else {
    // return true when we have internet
    return true;
  }
}
