import 'package:food_store/contants/image_contants.dart';
import 'package:food_store/restaurant/model/restaurant.dart';
import 'package:food_store/restaurant/model/restaurant_food.dart';

class RestaurantRepository {
  final List<Restaurant> _restaurants = List.generate(
    3,
    (index) {
      return const Restaurant(
        id: '1dsrhe2fbfd3456',
        name: 'Kinka Izakaya',
        address: '398 Church St, Toronto, ON M5B 2A2',
        restaurantLogo: ImageContants.restaurantLogo,
        restaurantThumbnail: ImageContants.restaurantThumbnail,
        mainCourse: 'Japanese',
        deliveryFee: 3.99,
        isFeatured: true,
        featuredImage: ImageContants.card,
        foods: [
          RestaurantFood(
            id: '1',
            name: 'Udon Miso',
            price: 16,
            description: 'Thick handmade  udon noodles in a rich miso broth',
            imgUrl: ImageContants.foodInBowl,
            restaurantId: '1dsrhe2fbfd3456',
          ),
          RestaurantFood(
            id: '2',
            name: 'Udon Miso',
            price: 16,
            description: 'Thick handmade  udon noodles in a rich miso broth',
            imgUrl: ImageContants.foodInBowl,
            restaurantId: '1dsrhe2fbfd3456',
          ),
          RestaurantFood(
            id: '3',
            name: 'Udon Miso',
            price: 16,
            description: 'Thick handmade  udon noodles in a rich miso broth',
            imgUrl: ImageContants.foodInBowl,
            restaurantId: '1dsrhe2fbfd3456',
          ),
        ],
      );
    },
  ).toList();

  Future<List<Restaurant>> getRestaurants() async {
    return _restaurants;
  }

  Future<List<Restaurant>> getFeaturedRestaurant() async {
    return _restaurants.where((restaurant) => restaurant.isFeatured).toList();
  }
}
