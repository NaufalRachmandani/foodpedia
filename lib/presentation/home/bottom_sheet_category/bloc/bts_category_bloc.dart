import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodpedia/domain/use_case/food/get_food_category.dart';

part 'bts_category_event.dart';

part 'bts_category_state.dart';

class BtsCategoryBloc extends Bloc<BtsCategoryEvent, BtsCategoryState> {
  GetFoodCategory getFoodCategory;

  BtsCategoryBloc({required this.getFoodCategory})
      : super(BtsCategoryLoadingState()) {
    on<BtsGetCategoryEvent>(_getCategory);
    on<BtsSearchCategoryEvent>(_searchCategory);
  }

  void _getCategory(
      BtsGetCategoryEvent event, Emitter<BtsCategoryState> emit) async {
    final result = await getFoodCategory.execute();
    await result.fold(
      (failure) async {
        emit(BtsCategoryNotFoundState());
      },
      (foodCategoryResponse) async {
        List<String> list = [];

        foodCategoryResponse.meals?.forEach((element) {
          list.add(element.strCategory ?? '');
        });

        emit(BtsCategoryLoadedState(
            listCategory: list, filteredListCategory: list));
      },
    );
  }

  void _searchCategory(
      BtsSearchCategoryEvent event, Emitter<BtsCategoryState> emit) async {
    if (state is BtsCategoryLoadedState) {
      BtsCategoryLoadedState btsCategoryLoadedState =
          state as BtsCategoryLoadedState;

      List<String> list = [];

      for (var element in btsCategoryLoadedState.listCategory) {
        if (element.toLowerCase().contains(event.query.toLowerCase())) {
          list.add(element);
        }
      }

      emit(BtsCategoryLoadedState(
        listCategory: btsCategoryLoadedState.listCategory,
        filteredListCategory: list,
      ));
    }
  }
}
