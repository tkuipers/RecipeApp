// import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/cupertino/list_view.dart'
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/styles.dart';
import 'package:recipe_app/widgets/recipe_card.dart';
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
                flex: 1,
                child: CupertinoListView
                // child: CupertinoListView.builder(
                //   sectionCount: 2,
                //   padding: const EdgeInsets.all(8.0),
                //   sectionBuilder: (context, sectionPath, isFloating) {
                //     switch (sectionPath.section) {
                //       case 0:
                //         return Container(
                //             height: 90,
                //             constraints: BoxConstraints(minHeight: 100),
                //             child: CupertinoTextField(
                //               controller:
                //                   TextEditingController(text: "Ingredients"),
                //               textAlign: TextAlign.center,
                //               style: const TextStyle(fontSize: 25),
                //               // cursorHeight: 45,
                //               // maxLines: 4,
                //             ));
                //       case 1:
                //       default:
                //         return const Text(
                //           "Instructions",
                //           textScaleFactor: 1.5,
                //           textAlign: TextAlign.center,
                //         );
                //     }
                //   },
                //   childBuilder: (BuildContext context, IndexPath index) {
                //     switch (index.section) {
                //       case 0:
                //         return RecipeAppEditableText(
                //             text: recipe.ingredientsList[index.child]);
                //       case 1:
                //       default:
                //         return RecipeAppEditableText(
                //             text: recipe.instructionsList[index.child]);
                //     }
                //   },
                //   itemInSectionCount: (int section) {
                //     switch (section) {
                //       case 0:
                //         return recipe.ingredientsList.length;
                //       case 1:
                //       default:
                //         return recipe.instructionsList.length;
                //     }
                //   },
                // ))
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
