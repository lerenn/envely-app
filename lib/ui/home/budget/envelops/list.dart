import 'package:flutter/material.dart';

import 'package:Envely/models/models.dart';

abstract class EnvelopListItem {
  Widget content();
  Color color(BuildContext context);
}

class EnvelopCategoryItem implements EnvelopListItem {
  final String name;

  EnvelopCategoryItem(this.name);

  Widget content() => Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Color color(BuildContext context) => Theme.of(context).backgroundColor;
}

class EnvelopItem implements EnvelopListItem {
  final String name;

  EnvelopItem(this.name);

  Widget content() => Text(name);

  Color color(BuildContext context) => Theme.of(context).secondaryHeaderColor;
}

class EnvelopList extends StatelessWidget {
  final List<Envelop> envelops;

  EnvelopList(this.envelops);

  @override
  Widget build(BuildContext context) {
    List<String> categories = List<String>();
    List<EnvelopListItem> items = List<EnvelopListItem>();

    // Create categories list
    envelops.forEach((envelop) {
      if (!categories.contains(envelop.category))
        categories.add(envelop.category);
    });

    // Create categories list
    categories.forEach((category) {
      // Add item category
      items.add(EnvelopCategoryItem(category));

      // Add items envelops
      envelops.forEach((envelop) {
        if (category == envelop.category) items.add(EnvelopItem(envelop.name));
      });
    });

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
            decoration: new BoxDecoration(color: item.color(context)),
            child: ListTile(
              title: item.content(),
            ));
      },
    );
  }
}
