import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// ✅ الكلاس ده مسؤول عن متابعة حالة الإنترنت في التطبيق كله
class InternetProvider extends ChangeNotifier {

  bool _isConnected = true; // الحالة الافتراضية إن في نت
  bool get isConnected => _isConnected; // نقدر نوصل للحالة دي من أي صفحة

  InternetProvider() {

    // بنسمع لأي تغيير في نوع الشبكة (واي فاي / داتا)
    Connectivity().onConnectivityChanged.listen((_) async {

      // بنتأكد هل في إنترنت فعلي ولا لا
      bool status = await InternetConnectionChecker().hasConnection;

      // لو الحالة اتغيرت نحدثها
      if (_isConnected != status) {
        _isConnected = status;

        notifyListeners(); // 🔔 يبلغ كل الصفحات اللي بتستخدم Provider
      }
    });
  }
}