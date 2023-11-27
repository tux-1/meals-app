import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    //navigating to next page (single route)
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return CategoryMealsScreen();
    // }))
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //InkWell is the same as gesture detector except it also has
      // ripple effect on tap
      onTap: () => selectCategory(context),
      // splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
