import 'package:service_electronic/core/constant/bottun.dart';
import 'package:flutter/material.dart';

class buttonservice extends StatelessWidget {
  final DecorationImage? image;
  final String title;
  final String text;
  final String text1;
  final String text2;
  final String text3;
  final String prx;
  final String prx1;
  final String prx2;
  const buttonservice(
      {Key? key,
      required this.image,
      required this.title,
      required this.text,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.prx,
      required this.prx1,
      required this.prx2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: w * 0.73,
            height: h * 0.25,
            decoration: BoxDecoration(
              image: image,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 20),
            child: FittedBox(
                child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                          child: Text(
                        prx,
                        style: const TextStyle(fontSize: 20),
                      )),
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: w * 0.04,
                          )),
                      Container(
                        height: h * 0.06,
                        width: w * 0.42,
                        child: myMaterialButton(
                          color: Colors.blue,
                          onPressed: () {},
                          text: text1,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                          child: Text(
                        prx1,
                        style: const TextStyle(fontSize: 20),
                      )),
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: w * 0.04,
                          )),
                      Container(
                        height: h * 0.06,
                        width: w * 0.39,
                        child: myMaterialButton(
                          color: Colors.blue,
                          onPressed: () {},
                          text: text2,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                          child: Text(
                        prx2,
                        style: const TextStyle(fontSize: 20),
                      )),
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: w * 0.04,
                          )),
                      Container(
                        height: h * 0.06,
                        width: w * 0.53,
                        child: myMaterialButton(
                          color: Colors.blue,
                          onPressed: () {},
                          text: text3,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
