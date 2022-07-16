import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class Category {
  String? id;
  String? description;

  Category({required this.id, required this.description});

  Category.fromParse(ParseObject parseObject)
      : id = parseObject.objectId!,
        description = parseObject.get<String>(keyCategoryDescription);

  @override
  String toString() {
    return 'Category{id: $id, description: $description}';
  }
}
