import 'package:flutter/material.dart';

class DialogService {
  DialogService(this.navigatorKey);

  GlobalKey<NavigatorState>? navigatorKey;

  BuildContext get _context {
    final context = navigatorKey?.currentContext;
    if (context == null) {
      throw StateError(
        'Navigator context is not available. Ensure DialogService is configured with AppRouter.rootNavigatorKey.',
      );
    }
    return context;
  }

  void closeDialog<T extends Object?>([T? result]) {
    final navigator = navigatorKey?.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop(result);
    }
  }

  Future<T?> openDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    return showDialog<T>(
      context: _context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: builder,
    );
  }
}
