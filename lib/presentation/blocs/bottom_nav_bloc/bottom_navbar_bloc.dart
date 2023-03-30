import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(const BottomNavbarInitial(0)) {
    on<BottomNavbarChangeTabEvent>((event, emit) {
      emit(BottomNavbarInitial(event.currentIndex));
    });
  }
}
