class City {
  String? id;
  String name;

  City({this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) =>
      City(id: json["id"], name: json["nome"]);

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
