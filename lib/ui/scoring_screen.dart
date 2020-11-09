import 'package:flutter/material.dart' hide Action;
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/service/scoring_service.dart';
import 'package:iron_bank/service/statement_service.dart';

import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

///View
class ScoringScreen extends CoreMwwmWidget {
  ScoringScreen({
    Key key,
    WidgetModelBuilder wmBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: wmBuilder ??
              (context) => ScoringScreenModel(
                    WidgetModelDependencies(),
                    Navigator.of(context),
                  ),
        );

  @override
  State<StatefulWidget> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends WidgetState<ScoringScreenModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: EntityStateBuilder(
          streamedState: wm.creditState,
          child: (_, credit) => credit == null
              ? RaisedButton(
                  child: Text('Get credit limit'),
                  onPressed: wm.getCreditDataAction,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('credit limit: $credit'),
                    SizedBox(height: 16.0),
                    RaisedButton(
                      child: Text('Get one more time'),
                      onPressed: wm.refreshAction,
                    )
                  ],
                ),
          loadingChild: Text('loading...'),
          errorChild: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('errorChild'),
              SizedBox(height: 16.0),
              RaisedButton(
                child: Text('Refresh'),
                onPressed: wm.refreshAction,
              )
            ],
          ),
          errorBuilder: (_, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('errorBuilder'),
              SizedBox(height: 16.0),
              RaisedButton(
                child: Text('Refresh'),
                onPressed: wm.refreshAction,
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// VM для [ScoringScreen]
class ScoringScreenModel extends WidgetModel {
  final NavigatorState _navigator;
  final ScoringService _scoringService;

  ScoringScreenModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  )   : _scoringService = getIt.get<ScoringService>(),
        super(dependencies);

  final creditState = EntityStreamedState<Money>()..content(null);
  final refreshAction = Action<void>();
  final getCreditDataAction = Action<void>();

  @override
  void onBind() {
    super.onBind();

    subscribe(refreshAction.stream, _getCreditLimit);
    subscribe(getCreditDataAction.stream, _getCreditLimit);
  }

  void _getCreditLimit(_) {
    creditState.loading();
    doFuture(
      _scoringService.getCreditLimit(),
      (limit) => creditState.content(limit),
      onError: (error) => creditState.error(error),
    );
  }
}
