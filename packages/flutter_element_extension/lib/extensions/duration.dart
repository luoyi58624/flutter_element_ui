import 'dart:async';

extension ElDurationExtension on Duration {
  Future delay([FutureOr Function()? callback]) async =>
      Future.delayed(this, callback);
}
