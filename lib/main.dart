import 'package:flutter/material.dart';
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/ui/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDi();
  runApp(MyApp());
}
