import 'dart:async';

extension DartDurationExtension on Duration {
  Future delay([FutureOr Function()? callback]) async =>
      Future.delayed(this, callback);
}
