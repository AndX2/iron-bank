import 'package:flutter/material.dart' hide Action;
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/service/scoring_service.dart';
import 'package:iron_bank/service/statement_service.dart';

import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

///View
class MoneyScreen extends CoreMwwmWidget {
  MoneyScreen({
    Key key,
    WidgetModelBuilder wmBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: wmBuilder ??
              (context) => MoneyScreenModel(
                    WidgetModelDependencies(),
                    Navigator.of(context),
                  ),
        );

  @override
  State<StatefulWidget> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends WidgetState<MoneyScreenModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: EntityStateBuilder(
          streamedState: wm.balanceState,
          child: (_, balance) => Text('balance: $balance'),
          loadingBuilder: (_, __) => Text('loading builder'),
          loadingChild: Text('loading'),
          // errorChild: Text('errorChild'),
          errorBuilder: (_, __) => Text('errorBuilder'),
        ),
      ),
    );
  }
}

/// VM для [MoneyScreen]
class MoneyScreenModel extends WidgetModel {
  final NavigatorState _navigator;
  final StatementService _statementService;
  final ScoringService _scoringService;

  MoneyScreenModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  )   : _statementService = getIt.get<StatementService>(),
        _scoringService = getIt.get<ScoringService>(),
        super(dependencies);

  final balanceState = EntityStreamedState<Money>()..loading();
  final refreshAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(
      _statementService.balanceObservable,
      (money) {
        balanceState.content(money);
      },
      onError: (error) {
        balanceState.error(error);
      },
    );
    _init();
    subscribe<void>(
      refreshAction.stream,
      (_) {
        balanceState.loading();
        _statementService.refreshBalance();
      },
    );
  }

  void _init() {
    if (balanceState.value?.data != null) return;
    _statementService.refreshBalance();
  }
}
