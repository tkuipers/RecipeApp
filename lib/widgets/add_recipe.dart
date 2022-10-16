import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/dto/recipe.dart';
import 'package:recipe_app/repository/recipes_repository.dart';
import 'package:recipe_app/widgets/recipes_widget.dart';

class AddRecipeDialogue extends StatefulWidget {
  const AddRecipeDialogue({super.key, required this.onAdd});

  final void Function(Recipe recipe) onAdd;

  @override
  State<StatefulWidget> createState() => _AddRecipeState(onAdd: this.onAdd);
}

class _AddRecipeState extends State<AddRecipeDialogue> {
  _AddRecipeState({required this.onAdd});

  final void Function(Recipe recipe) onAdd;
  @override
  Widget build(BuildContext parentContext) {
    var clipBoardData = Clipboard.getData(Clipboard.kTextPlain);
    var controller = TextEditingController();
    return CupertinoAlertDialog(
      title: const Text('Add Recipe'),
      content: const Text('Paste the URL below.'),
      actions: <Widget>[
        FutureBuilder<ClipboardData?>(
          future: clipBoardData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controller.text = snapshot.data!.text ?? "";
              return CupertinoTextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: controller);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CupertinoActivityIndicator();
          },
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            var newRecipe =
                RecipesRepo.add(NewRecipeDTO(Uri.parse(controller.text)));
            newRecipe.then((value) {
              onAdd(value);
            });
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
