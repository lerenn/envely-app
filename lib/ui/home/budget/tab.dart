import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/ui/common/common.dart';

import 'envelops/envelops.dart';

class BudgetTab extends StatefulWidget {
  @override
  _BudgetTabState createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: SafeArea(
      child: Center(child: EnvelopsArea()),
    ));
  }
}

class EnvelopsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvelopsBloc, EnvelopsState>(builder: (context, state) {
      if (state is EnvelopsLoadSuccess) return EnvelopList(state.envelops);
      if (state is EnvelopsLoadFailure)
        return LoadFailure(
            message: "test",
            bloc: BlocProvider.of<EnvelopsBloc>(context),
            reloadAction: EnvelopsLoad(BudgetControllerSingleton().budget));
      return Loading(false);
    });
  }
}
