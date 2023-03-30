part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object> get props => [];
}

class BottomNavbarChangeTabEvent extends BottomNavbarEvent {
  final int currentIndex;
  const BottomNavbarChangeTabEvent(this.currentIndex);
}
