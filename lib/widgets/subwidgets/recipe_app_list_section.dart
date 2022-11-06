import 'package:flutter/cupertino.dart';

class RecipeAppListSection extends StatefulWidget {
  RecipeAppListSection(
      {super.key, required this.header, required this.children});

  final Widget header;
  final List<Widget> children;

  @override
  State<StatefulWidget> createState() =>
      _RecipeAppListSection(header: header, children: children);
}

class _RecipeAppListSection extends State<RecipeAppListSection> {
  _RecipeAppListSection({required this.header, required this.children});

  final Widget header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: children,
        ),
        header
      ],
    );
  }
}
