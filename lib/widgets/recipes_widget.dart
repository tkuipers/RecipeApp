import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/styles.dart';

final leftEditIcon = Container(
  color: Styles.faveYellow,
  alignment: Styles.centerLeft,
  child: const Icon(
    Icons.star,
    color: Styles.primaryColor,
  ),
);
final rightDeleteIcon = Container(
  color: Styles.deleteRed,
  alignment: Styles.centerRight,
  child: const Icon(
    Icons.delete,
    color: Styles.primaryColor,
  ),
);

class RecipesList extends StatelessWidget {
  const RecipesList({
    required this.recipes,
    super.key,
  });

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recipes.map((e) => RecipeCard(recipe: e)).toList(),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    required this.recipe,
    super.key,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 2,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(recipe.imageUrl.toString(),
                height: 80, width: 80, fit: BoxFit.fill),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe.title,
                    style: Styles.productRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Styles.primaryButtonColor,
                          ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      itemSize: 15)
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // final model = Provider.of<AppStateModel>(context, listen: false);
              // model.addProductToCart(product.id);
            },
            child: const Icon(
              CupertinoIcons.chevron_forward,
              semanticLabel: 'Add',
            ),
          ),
        ],
      ),
    );

    return Dismissible(
      key: ObjectKey(recipe.id),
      background: leftEditIcon,
      secondaryBackground: rightDeleteIcon,
      child: Column(
        children: <Widget>[
          row,
          Padding(
            padding: const EdgeInsets.only(
              left: 100,
              right: 16,
            ),
            child: Container(
              height: 1,
              color: Styles.primaryContrastingColor,
            ),
          ),
        ],
      ),
    );
  }
}
