import 'package:equatable/equatable.dart';

class RestaurantFood extends Equatable {
  const RestaurantFood({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imgUrl,
    required this.restaurantId,
  });

  final String id;
  final String name;
  final double price;
  final String description;
  final String imgUrl;
  final String restaurantId;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        imgUrl,
        restaurantId,
      ];
}
