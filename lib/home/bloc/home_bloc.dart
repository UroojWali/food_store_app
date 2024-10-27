import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/category/model/category.dart';
import 'package:food_store/category/repository/category_repository.dart';
import 'package:food_store/restaurant/model/restaurant.dart';
import 'package:food_store/restaurant/repository/restaurant_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required CategoryRepository categoryRepository,
    required RestaurantRepository featuredRepository,
  })  : _categoryRepository = categoryRepository,
        _featuredRepository = featuredRepository,
        super(const HomeState()) {
    on<HomeLoad>(_onHomeLoad);
  }

  final CategoryRepository _categoryRepository;
  final RestaurantRepository _featuredRepository;

  FutureOr<void> _onHomeLoad(
    HomeLoad event,
    Emitter<HomeState> emit,
  ) async {
    final categories = await _categoryRepository.getCategories();
    final featuredImages = await _featuredRepository.getFeaturedRestaurant();
    final nearYouRestaurant = await _featuredRepository.getRestaurants();
    emit(HomeState(
      categories: categories,
      featuredRestaurant: featuredImages,
      nearYouRestaurant: nearYouRestaurant,
    ));
  }
}
