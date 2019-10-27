import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';
import 'package:flutter_testes_teste/app/pages/home/services/button_text_service.dart';

import 'components/button_click_widget.dart';
import 'components/monitor_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double wX = size.width *0.3;
    double hX = size.width + wX;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              alignment: Alignment.bottomRight,
              height: 80,
              child: MonitorWidget(),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 405,
                maxHeight: 500
              ),
             height: hX,
              child: StaggeredGridView.countBuilder(

                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                itemCount: 18,
                itemBuilder: (BuildContext context, int index) =>
                    ButtonClickWidget(
                  text: HomeModule.to.get<ButtonTextService>().itemClick(
                        index,
                      ),
                  color: index == 15 ? Colors.orange[700] : Colors.grey[900],
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                    index == 16 ? 2 : 1, index == 15 ? 2 : 1),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
