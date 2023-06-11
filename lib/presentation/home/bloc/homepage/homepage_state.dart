part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();
}

class HomepageInitialState extends HomepageState {
  final String? category;

  const HomepageInitialState({this.category});

  @override
  List<Object> get props => [category ?? ''];
}
