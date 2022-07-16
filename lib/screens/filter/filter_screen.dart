import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/order_by_field.dart';
import 'package:xlo_mobx/screens/filter/components/price_range_field.dart';
import 'package:xlo_mobx/screens/filter/components/vendor_type_field.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

  FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrar Busca"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(
                  filterStore: filterStore,
                ),
                PriceRangeField(
                  filterStore: filterStore,
                ),
                VendorTypeField(
                  filterStore: filterStore,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 50,
                  child: Observer(
                    builder: (_) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 0),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => filterStore.isFormValid
                                  ? Theme.of(context).primaryColor
                                  : Colors.deepPurple[400],
                            )),
                        onPressed: filterStore.isFormValid
                            ? () {
                                filterStore.save();
                                Navigator.of(context).pop();
                              }
                            : null,
                        child: const Text(
                          "FILTRAR",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
