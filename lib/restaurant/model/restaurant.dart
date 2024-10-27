import 'package:equatable/equatable.dart';
import 'package:food_store/restaurant/model/restaurant_food.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.restaurantLogo,
    required this.restaurantThumbnail,
    this.isFeatured = false,
    this.featuredImage,
    this.mainCourse,
    required this.deliveryFee,
    required this.foods,
  });

  final String? id;
  final String name;
  final String address;
  final String restaurantLogo;
  final String restaurantThumbnail;
  final bool isFeatured;
  final String? featuredImage;
  final String? mainCourse;
  final double deliveryFee;
  final int avgDeliveryTime = 30;
  final double rating = 4.5;
  final List<RestaurantFood> foods;

  @override
  List<Object?> get props => [
        name,
        address,
        restaurantLogo,
        restaurantThumbnail,
        isFeatured,
        featuredImage,
        mainCourse,
        deliveryFee,
        avgDeliveryTime,
        rating,
        foods,
      ];
}
