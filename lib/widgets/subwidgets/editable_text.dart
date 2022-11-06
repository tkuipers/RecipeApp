import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeAppEditableText extends StatefulWidget {
  RecipeAppEditableText(
      {super.key,
      required this.text,
      required this.onChange,
      this.minLines,
      this.maxLines,
      this.keyboardType});

  String text;
  void Function(String s) onChange;
  int? minLines;
  int? maxLines;
  TextInputType? keyboardType;

  @override
  State<StatefulWidget> createState() => _EditableText(
      text: text,
      onChange: onChange,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 10,
      keyboardType: keyboardType ?? TextInputType.text);
}

class _EditableText extends State<RecipeAppEditableText> {
  _EditableText(
      {required this.text,
      required this.onChange,
      required this.minLines,
      required this.maxLines,
      required this.keyboardType});
  late TextEditingController _textController;
  int minLines;
  int maxLines;
  TextInputType keyboardType;

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
  void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: (value) => onChange(value),
      keyboardType: keyboardType,
      controller: _textController,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
