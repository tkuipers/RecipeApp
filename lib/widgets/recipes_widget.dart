// import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/repository/recipes_repository.dart';
import 'package:recipe_app/styles.dart';
import 'package:recipe_app/widgets/subwidgets/editable_text.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({required this.recipe, super.key});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(recipe.title)),
        child: Column(
          children: [
            Expanded(flex: 1, child: _TopPortion(imageUrl: recipe.imageUrl)),
            Expanded(
                flex: 0,
                child: RatingBar.builder(
                    initialRating: recipe.rating ?? 0,
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
                      recipe.rating = rating;
                      RecipesRepo.update(recipe);
                    },
                    itemSize: 30)),
            Expanded(
                flex: 2,
                child: CupertinoListView.builder(
                  sectionCount: 3,
                  padding: const EdgeInsets.all(8.0),
                  sectionBuilder: (context, sectionPath, isFloating) {
                    switch (sectionPath.section) {
                      case 0:
                        return Container(
                            child: CupertinoTextField(
                          controller:
                              TextEditingController(text: "Ingredients"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ));
                      case 1:
                        return Container(
                            child: CupertinoTextField(
                          controller:
                              TextEditingController(text: "Instructions"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          // cursorHeight: 45,
                          // maxLines: 4,
                        ));
                      case 2:
                      default:
                        return Container(
                            child: CupertinoTextField(
                          controller: TextEditingController(text: "Notes"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          // cursorHeight: 45,
                          // maxLines: 4,
                        ));
                    }
                  },
                  childBuilder: (BuildContext context, IndexPath index) {
                    switch (index.section) {
                      case 0:
                        return RecipeAppEditableText(
                            text: recipe.ingredientsList[index.child],
                            onChange: (updated) {
                              recipe.ingredientsList[index.child] = updated;
                              RecipesRepo.update(recipe);
                            });
                      case 1:
                        return RecipeAppEditableText(
                            text: recipe.instructionsList[index.child],
                            keyboardType: TextInputType.multiline,
                            maxLines: 30,
                            onChange: (updated) {
                              recipe.instructionsList[index.child] = updated;
                              RecipesRepo.update(recipe);
                            });
                      case 2:
                      default:
                        return RecipeAppEditableText(
                            text: recipe.notes,
                            minLines: 10,
                            maxLines: 50,
                            keyboardType: TextInputType.multiline,
                            onChange: (updated) {
                              recipe.notes = updated;
                              RecipesRepo.update(recipe);
                            });
                    }
                  },
                  itemInSectionCount: (int section) {
                    switch (section) {
                      case 0:
                        return recipe.ingredientsList.length;
                      case 1:
                        return recipe.instructionsList.length;
                      case 2:
                      default:
                        return 1;
                    }
                  },
                ))
          ],
        )
        //
        );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment(-.2, 0),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
      ],
    );
  }
}
