import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/repository/recipes_repository.dart';
import 'package:recipe_app/styles.dart';
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
    futureRecipes = RecipesRepo.fetchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: futureRecipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("Recipes"),
              trailing: Icon(CupertinoIcons.add),
            ),
            child: RecipesList(recipes: snapshot.data!),
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
