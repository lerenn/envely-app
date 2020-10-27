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
  final List<Category> categories;
  final List<Envelop> envelops;
  final List<EnvelopListItem> items = List<EnvelopListItem>();

  EnvelopList(this.categories, this.envelops) {
    // Sort lists
    categories.sort((a, b) => a.position.compareTo(b.position));

    // Create items
    categories.forEach((category) {
      // Add item category
      items.add(EnvelopCategoryItem(category.name));

      // Add items envelops
      envelops.forEach((envelop) {
        if (category.name == envelop.category)
          items.add(EnvelopItem(envelop.name));
      });
    });

    // Create a category for items with no category
    items.add(EnvelopCategoryItem("Orphaned envelops"));
    envelops.forEach((envelop) {
      // Check if the envelop is orphaned
      bool orphan = true;
      for (final category in categories) {
        if (category.name == envelop.category) {
          orphan = false;
          break;
        }
      }

      // Add it to orphan category
      if (orphan) items.add(EnvelopItem(envelop.name));
    });
  }

  @override
  Widget build(BuildContext context) {
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
