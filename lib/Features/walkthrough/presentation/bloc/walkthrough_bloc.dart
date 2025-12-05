import 'package:flutter_bloc/flutter_bloc.dart';

part 'walkthrough_event.dart';
part 'walkthrough_state.dart';

class WalkthroughBloc extends Bloc<WalkthroughEvent, WalkthroughState> {
  final int totalSteps;

  WalkthroughBloc({this.totalSteps = 3}) : super(WalkthroughInitial()) {
    on<WalkthroughNext>((event, emit) {
      final currentIndex = state is WalkthroughInitial
          ? (state as WalkthroughInitial).currentIndex
          : (state as WalkthroughInProgress).currentIndex;

      if (currentIndex < totalSteps - 1) {
        emit(WalkthroughInProgress(currentIndex + 1));
      } else {
        emit(WalkthroughFinished());
      }
    });

    on<WalkthroughSkip>((event, emit) => emit(WalkthroughFinished()));
  }
}
