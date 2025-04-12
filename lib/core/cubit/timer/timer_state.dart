part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final int totalSeconds;
  final bool? isRunning;

  const TimerState({required this.totalSeconds, this.isRunning});

  String get formatted {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({int? totalSeconds, bool? isRunning}) {
    return TimerState(totalSeconds: totalSeconds ?? this.totalSeconds, isRunning: isRunning ?? this.isRunning);
  }

  @override
  List<Object> get props => [totalSeconds];
}
