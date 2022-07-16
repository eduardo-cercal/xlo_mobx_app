import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  final FilterStore filterStore;

  const OrderByField({Key? key, required this.filterStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy orderBy) {
      return GestureDetector(
        onTap: () {
          filterStore.setOrderBy(orderBy);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: filterStore.orderBy == orderBy
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: filterStore.orderBy == orderBy
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              )),
          child: Text(
            title,
            style: TextStyle(
              color:
                  filterStore.orderBy == orderBy ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Ordenar Por"),
        Observer(builder: (_) {
          return Row(
            children: [
              buildOption("Data", OrderBy.date),
              const SizedBox(
                width: 12,
              ),
              buildOption("Preço", OrderBy.price),
            ],
          );
        })
      ],
    );
  }
}
