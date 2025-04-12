import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit({int initialSeconds = 60}) : _initialSeconds = initialSeconds, super(TimerState(totalSeconds: initialSeconds, isRunning: false));

  final int _initialSeconds;
  Timer? _timer;

  bool get isActive => state.totalSeconds > 0 && state.isRunning == true;

  void start() {
    if (_timer != null || state.totalSeconds <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newSeconds = state.totalSeconds - 1;
      if (newSeconds <= 0) {
        stop();
        return;
      }
      emit(state.copyWith(totalSeconds: newSeconds));
    });

    emit(state.copyWith(isRunning: true));
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
    emit(state.copyWith(isRunning: false));
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    emit(TimerState(totalSeconds: _initialSeconds, isRunning: false));
  }

  void update(int seconds) {
    if (seconds <= 0) return;
    _timer?.cancel();
    _timer = null;
    emit(TimerState(totalSeconds: seconds, isRunning: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
