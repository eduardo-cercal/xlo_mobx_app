class UF {
  int? id;
  String initials;
  String? name;

  UF({this.id, required this.initials, this.name});

  factory UF.fromJson(Map<String, dynamic> json) =>
      UF(id: json["id"], initials: json["sigla"], name: json["nome"]);

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }
}
