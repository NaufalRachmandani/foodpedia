import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {

  HomepageBloc() : super(const HomepageInitialState()) {
    on<UpdateCategoryEvent>(_updateCategory);
  }

  void _updateCategory(
      UpdateCategoryEvent event, Emitter<HomepageState> emit) async {
    emit(HomepageInitialState(category: event.category));
  }
}
