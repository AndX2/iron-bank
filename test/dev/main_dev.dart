import 'package:flutter/material.dart';
import 'package:iron_bank/ui/my_app.dart';

import 'di/di_container_dev.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDiDev();
  runApp(MyApp());
}
