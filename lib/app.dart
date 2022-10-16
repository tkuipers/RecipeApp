import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/repository/recipes_repository.dart';
import 'package:recipe_app/styles.dart';
import 'package:recipe_app/widgets/add_recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';
import 'package:recipe_app/widgets/recipes_widget.dart';
import 'package:http/http.dart' as http;

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

// {
//     Brightness? brightness,
//     Color? primaryColor,
//     Color? primaryContrastingColor,
//     CupertinoTextThemeData? textTheme,
//     Color? barBackgroundColor,
//     Color? scaffoldBackgroundColor,
//   }
    return const CupertinoApp(
      theme: CupertinoThemeData(
          primaryColor: Styles.primaryColor,
          primaryContrastingColor: Styles.primaryContrastingColor,
          barBackgroundColor: Styles.barBackgroundColor,
          scaffoldBackgroundColor: Styles.scaffoldBackgroundColor),
      home: RecipesApp(),
    );
  }
}

class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key});
  @override
  State<RecipesApp> createState() => _RecipesAppState();

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //       navigationBar: CupertinoNavigationBar(
  //         middle: const Text('Recipes'),
  //       ),
  //       child: RecipeCard(recipe: thisRecipe));
  // }
}

class _RecipesAppState extends State<RecipesApp> {
  Future<List<Recipe>>? futureRecipes;

  @override
  void initState() {
    super.initState();
    updateRecipes();
  }

  void updateRecipes() {
    futureRecipes = RecipesRepo.fetchAllRecipes();
  }

  @override
  Widget build(BuildContext rootContext) {
    return FutureBuilder<List<Recipe>>(
      future: futureRecipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Recipes"),
              trailing: GestureDetector(
                  onTap: () => {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) =>
                                AddRecipeDialogue(onAdd: (recipe) {
                                  updateRecipes();
                                  setState(() {});
                                  Navigator.push(
                                    rootContext,
                                    CupertinoPageRoute(
                                        builder: (rootContext) =>
                                            RecipeDetails(recipe: recipe)),
                                  );
                                })).then((value) => updateRecipes())
                      },
                  child: const Icon(CupertinoIcons.add)),
            ),
            child: RecipesList(
              recipes: snapshot.data!,
              onRecipeDelete: (recipe) {
                snapshot.data!
                    .removeWhere((element) => element.id == recipe.id);
                RecipesRepo.delete(recipe).then((value) => setState(() {}));
              },
              onRecipeFavourite: (recipe) {
                snapshot.data!
                    .removeWhere((element) => element.id == recipe.id);
                RecipesRepo.delete(recipe).then((value) => setState(() {}));
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CupertinoActivityIndicator();
      },
    );
  }
}

class RecipesList extends StatelessWidget {
  const RecipesList({
    required this.recipes,
    required this.onRecipeDelete,
    required this.onRecipeFavourite,
    super.key,
  });

  final List<Recipe> recipes;
  final void Function(Recipe recipe) onRecipeDelete;
  final void Function(Recipe recipe) onRecipeFavourite;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recipes
          .map((e) => RecipeCard(
                recipe: e,
                onDelete: onRecipeDelete,
                onFavourite: onRecipeFavourite,
              ))
          .toList(),
    );
  }
}
