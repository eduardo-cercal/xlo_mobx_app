import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

enum AdStatus { pending, active, sold, deleted }

class Ad {
  String? id;
  late List images;
  late String title;
  late String description;
  late Category category;
  late Address address;
  late num price;
  late bool hidePhone;
  late AdStatus status;
  DateTime? createAt;
  late User user;
  int? views;

  Ad(
      {this.id,
      required this.images,
      required this.title,
      required this.description,
      required this.category,
      required this.address,
      required this.price,
      required this.hidePhone,
      this.status = AdStatus.pending,
      this.createAt,
      required this.user,
      this.views});

  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle)!;
    description = object.get<String>(keyAdDescription)!;
    images = object.get<List>(keyAdImages)!.map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone)!;
    price = object.get<num>(keyAdPrice)!;
    createAt = object.createdAt;
    address = Address(
      uf: UF(initials: object.get<String>(keyAdFederativeUnit)!),
      city: City(name: object.get<String>(keyAdCity)!),
      cep: object.get<String>(keyAdPostalCode)!,
      district: object.get<String>(keyAdDistrict)!,
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner)!);
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory)!);
    status = AdStatus.values[object.get<int>(keyAdStatus)!];
  }

  @override
  String toString() {
    return 'Ad{id: $id, images: $images, title: $title, description: $description, category: $category, address: $address, price: $price, hidePhone: $hidePhone, status: $status, createAt: $createAt, user: $user, views: $views}';
  }
}
