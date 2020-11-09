import 'package:flutter/material.dart';
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/service/settings_service.dart';
import 'package:iron_bank/ui/root_routes.dart';

import 'package:mwwm/mwwm.dart';

class SplashScreenRoute extends MaterialPageRoute {
  SplashScreenRoute() : super(builder: (context) => SplashScreen());
}

///View
class SplashScreen extends CoreMwwmWidget {
  SplashScreen({
    Key key,
    WidgetModelBuilder wmBuilder,
  }) : super(
          widgetModelBuilder: wmBuilder ??
              (context) => SplashScreenModel(
                    WidgetModelDependencies(),
                    Navigator.of(context),
                  ),
        );

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends WidgetState<SplashScreenModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Image.asset('assets/image/raven.png'),
        ),
      ),
    );
  }
}

/// [nameModel] для [name]
class SplashScreenModel extends WidgetModel {
  /// пришедшие данные извне
  final NavigatorState _navigator;
  final SettingsService _settingsService;

  SplashScreenModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  )   : _settingsService = getIt.get<SettingsService>(),
        super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    _init();
  }

  @override
  void onBind() {
    super.onBind();
  }

  void _init() async {
    await _settingsService.fetchSettings();
    _navigator.pushReplacementNamed(RootRoutes.main);
  }
}
