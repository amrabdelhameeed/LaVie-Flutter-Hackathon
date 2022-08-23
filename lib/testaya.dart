import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Testaya extends StatefulWidget {
  Testaya({Key? key}) : super(key: key);

  @override
  State<Testaya> createState() => _TestayaState();
}

class _TestayaState extends State<Testaya> {
  var list = List.generate(20, (index) => index);
  ScrollController scrollController = ScrollController();
  int postion = 0;
  double ratio = 0;

  int height = 100;
  @override
  void initState() {
    scrollController.addListener(() {
      print(scrollController.position.pixels);
      postion = scrollController.position.pixels.toInt();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 250,
        margin: EdgeInsets.symmetric(vertical: 100),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index.isEven
                    ? Container(
                        color: Colors.red,
                        height: 30,
                      )
                    : SizedBox.shrink(),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 180,
                  color: Colors.green.shade300,
                  child: Column(
                    children: [Text(list[index].toString())],
                  ),
                ),
                index.isOdd
                    ? Container(
                        color: Colors.red,
                        height: 30,
                      )
                    : SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    );
  }
}
