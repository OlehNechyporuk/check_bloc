part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarState extends Equatable {
  final int index;
  const BottomNavbarState(this.index);

  @override
  List<Object> get props => [index];
}

class BottomNavbarInitial extends BottomNavbarState {
  const BottomNavbarInitial(super.index);
}
