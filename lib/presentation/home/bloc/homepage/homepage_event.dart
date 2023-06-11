part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();
}

class UpdateCategoryEvent extends HomepageEvent {
  final String category;

  const UpdateCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}