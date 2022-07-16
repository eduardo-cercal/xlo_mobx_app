import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  final FilterStore filterStore;

  const PriceRangeField({Key? key, required this.filterStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(filterStore.minPrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Preço"),
        Observer(builder: (_) {
          if (filterStore.priceError != null) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                filterStore.priceError!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            );
          } else {
            return Container();
          }
        }),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filterStore.setMinPrice,
              initialValue: filterStore.minPrice,
            ),
            const SizedBox(
              width: 12,
            ),
            PriceField(
              label: 'Max',
              onChanged: filterStore.setMaxPrice,
              initialValue: filterStore.maxPrice,
            ),
          ],
        ),
      ],
    );
  }
}
