import 'package:flutter/material.dart';

import '../model/category_data.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryData categoryData;

  const CategoryWidget({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Image.network(categoryData.imageUrl.toString()),
          ),
          Container(
              child: Text(
            categoryData.categoryName.toString(),
          ))
        ],
      ),
    );
  }
}
