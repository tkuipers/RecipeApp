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
    this.rating,
    this.favourite,
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
  double? rating;
  bool? favourite;
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
        json['rating'],
        json['favourite'],
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
        "rating": rating,
        "favourite": favourite,
        "ingredients_list": List<dynamic>.from(ingredientsList.map((x) => x)),
        "instructions_list": List<dynamic>.from(instructionsList.map((x) => x)),
      };
}

class NewRecipeDTO {
  Uri recipeUrl;

  NewRecipeDTO(this.recipeUrl);

  factory NewRecipeDTO.fromJson(Map<String, dynamic> json) =>
      NewRecipeDTO(json["recipe_url"]);

  Map<String, dynamic> toJson() => {
        "recipe_url": recipeUrl.toString(),
      };
}
