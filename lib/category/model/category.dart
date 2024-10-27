import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  List<Object?> get props => [name, image];
}
