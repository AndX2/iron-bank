import 'package:flutter/material.dart' hide Action;
import 'package:iron_bank/di/di_container.dart';
import 'package:iron_bank/domain/money.dart';
import 'package:iron_bank/service/scoring_service.dart';
import 'package:iron_bank/service/statement_service.dart';
import 'package:iron_bank/ui/util/media.dart';

import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

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
    final isMobile = context.maxSize < 1024;
    final accentColor = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SwipeRefresh.cupertino(
        scrollController: wm.scrollController,
        initState: SwipeRefreshState.hidden,
        stateStream: wm.swipeRefreshState.stream,
        children: [
          Container(
            margin: EdgeInsets.all(isMobile ? 12.0 : 24.0),
            height: 200.0,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: EntityStateBuilder<Money>(
              streamedState: wm.balanceState,
              child: (context, balance) =>
                  _buildBalance(balance, false, isMobile),
              loadingChild: Stack(
                children: [
                  Shimmer(
                    gradient: LinearGradient(
                      colors: [
                        accentColor,
                        accentColor,
                        accentColor.withAlpha(100),
                        accentColor,
                        accentColor
                      ],
                      stops: [0.0, 0.15, 0.5, 0.85, 1.0],
                      begin: Alignment(0.0, 1.0),
                      end: Alignment(-.15, -1.0),
                    ),
                    child: Container(),
                  ),
                  _buildBalance(null, true, isMobile),
                ],
              ),
              errorChild: Center(
                child: Text(
                  'Error! Try again later',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              'Operations:',
              style: TextStyle(fontSize: 24.0),
            ),
          )
        ],
        onRefresh: wm.refreshAction,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: wm.refreshAction,
      ),
    );
  }

  Widget _buildBalance([
    Money balance,
    bool isLoading = false,
    bool isMobile = false,
  ]) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMoneyCell('golden\ndragons',
              isLoading ? '' : balance.goldenDragons.toString(), isMobile),
          SizedBox(width: 32.0),
          _buildMoneyCell('silver\ndeers',
              isLoading ? '' : balance.silverDeers.toString(), isMobile),
          SizedBox(width: 32.0),
          _buildMoneyCell('copper\npenny',
              isLoading ? '' : balance.copperPenny.toString(), isMobile),
        ],
      ),
    );
  }

  Widget _buildMoneyCell(
    String name, [
    String value = '00',
    bool isMobile = false,
  ]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(4.0, 4.0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: isMobile ? 32.0 : 48.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: .5,
              width: isMobile ? 32.0 : 48.0,
              color: Colors.grey,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
          ),
        ],
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

  final balanceState = EntityStreamedState<Money>();
  final swipeRefreshState =
      StreamedState<SwipeRefreshState>(SwipeRefreshState.hidden);
  final refreshAction = Action<void>();
  final scrollController = ScrollController();

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
    subscribe(
      balanceState.stream,
      (_) {
        swipeRefreshState.accept(balanceState.value.isLoading
            ? SwipeRefreshState.loading
            : SwipeRefreshState.hidden);
      },
    );
  }

  void _init() {
    if (balanceState.value?.data != null) return;
    _statementService.refreshBalance();
  }
}
