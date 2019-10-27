import 'package:flutter/material.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';

import '../home_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MonitorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = HomeModule.to.bloc<HomeBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<String>(
          stream: bloc.typeExpressionOut,
          initialData: "0",
          builder: (context, snapshot) {
            String text = "0";
            if (snapshot.hasData && snapshot.data.isEmpty) {
              text = "0";
            } else {
              text = snapshot.data;
            }

            return AutoSizeText(
              text,
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 35),
            );
          }),
    );
  }
}
