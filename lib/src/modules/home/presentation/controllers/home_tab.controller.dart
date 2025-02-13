import 'package:rxdart/rxdart.dart';

abstract class IHomeTabController {
  final BehaviorSubject<int> index = BehaviorSubject<int>();
  void updateSelectTab(int value);
  void dispose();
}

class HomeTabController implements IHomeTabController {
  @override
  updateSelectTab(int value) {
    index.add(value);
  }

  @override
  void dispose() {
    index.close();
  }

  @override
  final BehaviorSubject<int> index = BehaviorSubject<int>.seeded(0);
}
