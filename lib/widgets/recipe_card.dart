import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/repository/recipes_repository.dart';
import 'package:recipe_app/styles.dart';
import 'package:recipe_app/widgets/recipes_widget.dart';

final leftEditIcon = Container(
  color: Styles.scaffoldBackgroundColor,
  alignment: Styles.centerLeft,
  child: const Icon(
    Icons.star,
    color: Styles.faveYellow,
  ),
);
final rightDeleteIcon = Container(
  color: Styles.scaffoldBackgroundColor,
  alignment: Styles.centerRight,
  child: const Icon(
    Icons.delete,
    color: Styles.deleteRed,
  ),
);
final leftDeleteIcon = Container(
  color: Styles.scaffoldBackgroundColor,
  alignment: Styles.centerLeft,
  child: const Icon(
    Icons.delete,
    color: Styles.deleteRed,
  ),
);

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    required this.recipe,
    required this.onDelete,
    required this.onFavourite,
    super.key,
  });

  final Recipe recipe;
  final void Function(Recipe deleted) onDelete;
  final void Function(Recipe recipe) onFavourite;

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
        child: GestureDetector(
          onTap: () => {showRecipeDetails(context)},
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
                          initialRating: recipe.rating ?? 0,
                          ignoreGestures: true,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Styles.primaryButtonColor,
                              ),
                          onRatingUpdate: (rating) {},
                          itemSize: 15)
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showRecipeDetails(context);
                },
                child: const Icon(
                  CupertinoIcons.chevron_forward,
                  semanticLabel: 'Add',
                ),
              ),
            ],
          ),
        ));

    return Dismissible(
      key: ObjectKey(recipe.id),
      background: leftDeleteIcon,
      secondaryBackground: rightDeleteIcon,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          onFavourite(recipe);
        } else {
          onDelete(recipe);
        }
      },
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

  Future<dynamic> showRecipeDetails(BuildContext context) {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => RecipeDetails(recipe: recipe)),
    );
  }
}
