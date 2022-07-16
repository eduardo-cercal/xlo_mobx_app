import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  final FilterStore filterStore;

  const VendorTypeField({Key? key, required this.filterStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: "Tipo de anunciante"),
        Observer(builder: (_) {
          return Wrap(
            runSpacing: 4,
            children: [
              GestureDetector(
                onTap: () {
                  if (filterStore.isTypeParticular) {
                    if (filterStore.isTypeProfessional) {
                      filterStore.resetVendorType(vendorTypeParticular);
                    } else {
                      filterStore.selectVendorType(vendorTypeProfessional);
                    }
                  } else {
                    filterStore.setVendorType(vendorTypeParticular);
                  }
                },
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeParticular
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: Border.all(
                          color: filterStore.isTypeParticular
                              ? Theme.of(context).primaryColor
                              : Colors.grey)),
                  alignment: Alignment.center,
                  child: Text(
                    "Particular",
                    style: TextStyle(
                        color: filterStore.isTypeParticular
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (filterStore.isTypeProfessional) {
                    if (filterStore.isTypeParticular) {
                      filterStore.resetVendorType(vendorTypeProfessional);
                    } else {
                      filterStore.selectVendorType(vendorTypeParticular);
                    }
                  } else {
                    filterStore.setVendorType(vendorTypeProfessional);
                  }
                },
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeProfessional
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: Border.all(
                          color: filterStore.isTypeProfessional
                              ? Theme.of(context).primaryColor
                              : Colors.grey)),
                  alignment: Alignment.center,
                  child: Text(
                    "Professional",
                    style: TextStyle(
                        color: filterStore.isTypeProfessional
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              )
            ],
          );
        })
      ],
    );
  }
}
