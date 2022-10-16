import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/styles.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({required this.recipe, super.key});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(recipe.title)),
        child: Text("Hello"));
  }
}
