import 'package:flutter/material.dart';

import '../home_bloc.dart';
import '../home_module.dart';

class ButtonClickWidget extends StatelessWidget {
  final String text;
  final Color color;

  const ButtonClickWidget({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = HomeModule.to.bloc<HomeBloc>();

    return Material(
      color: color ?? Colors.grey[900],
      child: InkWell(
        onTap: () {
          bloc.typeExpressionIn.add(text);
        },
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
