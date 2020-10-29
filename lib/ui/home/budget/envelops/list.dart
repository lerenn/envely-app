import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/ui/common/common.dart';

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

  @override
  String toString() => "Category $name";
}

class EnvelopItem implements EnvelopListItem {
  final String name;

  EnvelopItem(this.name);

  Widget content() => Text(name);

  Color color(BuildContext context) => Theme.of(context).secondaryHeaderColor;

  @override
  String toString() => "Envelop $name";
}

class BudgetList extends StatefulWidget {
  @override
  _BudgetListState createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  @override
  Widget build(BuildContext context) {
    return loadCategories(context);
  }

  Widget loadCategories(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
      if (state is CategoriesLoadSuccess)
        return sortAndDisplayByCategory(context, state.categories);
      if (state is CategoriesLoadFailure)
        return LoadFailure(
            message: "Cannot load envelops categories",
            bloc: BlocProvider.of<CategoriesBloc>(context),
            reloadAction: CategoriesLoad(BudgetControllerSingleton().budget));
      return Loading(false);
    });
  }

  Widget sortAndDisplayByCategory(
      BuildContext context, List<Category> categories) {
    // Sort categories by position
    categories.sort((a, b) => a.position.compareTo(b.position));

    return Column(
        children: List<Widget>.generate(categories.length,
            (index) => loadEnvelops(context, categories[index])));
  }

  Widget loadEnvelops(BuildContext context, Category category) {
    return BlocBuilder<EnvelopsBloc, EnvelopsState>(builder: (context, state) {
      if (state is EnvelopsLoadSuccess)
        return buildList(context, category, state.envelops);
      if (state is EnvelopsLoadFailure)
        return LoadFailure(
            message: "Cannot load envelops",
            bloc: BlocProvider.of<CategoriesBloc>(context),
            reloadAction:
                EnvelopsLoad(BudgetControllerSingleton().budget, category));
      return Loading(false);
    });
  }

  Widget buildList(
      BuildContext context, Category category, List<Envelop> envelops) {
    List<EnvelopListItem> items = List<EnvelopListItem>();

    // Sort envelops
    // envelops.sort((a, b) => a.position.compareTo(b.position));

    // Add item category
    items.add(EnvelopCategoryItem(category.name));

    // Add items envelops
    envelops.forEach((envelop) {
      items.add(EnvelopItem(envelop.name));
    });

    // items.forEach((element) {
    //   print(element);
    // });
    // return Column();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
