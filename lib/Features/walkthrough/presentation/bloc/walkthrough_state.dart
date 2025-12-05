part of 'walkthrough_bloc.dart';

abstract class WalkthroughState {}

class WalkthroughInitial extends WalkthroughState {
  final int currentIndex;
  WalkthroughInitial({this.currentIndex = 0});
}

class WalkthroughInProgress extends WalkthroughState {
  final int currentIndex;
  WalkthroughInProgress(this.currentIndex);
}

class WalkthroughFinished extends WalkthroughState {}
