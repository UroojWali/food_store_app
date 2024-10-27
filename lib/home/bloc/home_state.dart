part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.categories = const [],
    this.featuredRestaurant = const [],
    this.nearYouRestaurant = const [],
  });

  final List<Category> categories;
  final List<Restaurant> featuredRestaurant;
  final List<Restaurant> nearYouRestaurant;

  @override
  List<Object> get props => [categories, featuredRestaurant, nearYouRestaurant];
}
