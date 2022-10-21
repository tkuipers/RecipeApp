import 'package:flutter/cupertino.dart';

class RecipeAppEditableText extends StatefulWidget {
  RecipeAppEditableText({super.key, required this.text});

  String text;

  @override
  State<StatefulWidget> createState() => _EditableText(text: this.text);
}

class _EditableText extends State<RecipeAppEditableText> {
  _EditableText({required this.text});
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: text);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  String text;
  bool isBeingEdited = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      showCursor: !isBeingEdited,
      readOnly: !isBeingEdited,
      controller: _textController,
      minLines: 1,
      maxLines: 10,
    );
  }
}
