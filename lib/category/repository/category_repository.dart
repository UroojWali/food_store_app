import 'package:food_store/category/model/category.dart';
import 'package:food_store/contants/image_contants.dart';

class CategoryRepository {
  CategoryRepository();

  Future<List<Category>> getCategories() async {
    return [
      const Category(name: 'Burgers', image: ImageContants.burger),
      const Category(name: 'Desert', image: ImageContants.cake),
      const Category(name: 'Mexican', image: ImageContants.taco),
      const Category(name: 'Sushi', image: ImageContants.sushiImage),
    ];
  }
}
