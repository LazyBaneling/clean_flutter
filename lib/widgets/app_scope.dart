import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    Key? key,
    required Widget child,
    this.cacheManager,
  }) : super(key: key, child: child);

  final CacheManager? cacheManager;

  static CacheManager cacheManagerOf(BuildContext context) {
    return _of(context).cacheManager ?? DefaultCacheManager();
  }

  static AppScope _of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(result != null, 'No CacheManagerScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
