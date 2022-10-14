class Recipe {
  Recipe(
    this.id,
    this.url,
    this.title,
    this.totalTime,
    this.imageUrl,
    this.host,
    this.yields,
    this.notes,
    this.ingredientsList,
    this.instructionsList,
  );

  int id;
  String url;
  String title;
  String totalTime;
  String imageUrl;
  String host;
  String yields;
  String notes;
  List<String> ingredientsList;
  List<String> instructionsList;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        json["id"],
        json["url"],
        json["title"],
        json["total_time"],
        json["image_url"],
        json["host"],
        json["yields"],
        json["notes"],
        List<String>.from(json["ingredients_list"].map((x) => x)),
        List<String>.from(json["instructions_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
        "total_time": totalTime,
        "image_url": imageUrl,
        "host": host,
        "yields": yields,
        "notes": notes,
        "ingredients_list": List<dynamic>.from(ingredientsList.map((x) => x)),
        "instructions_list": List<dynamic>.from(instructionsList.map((x) => x)),
      };
}
