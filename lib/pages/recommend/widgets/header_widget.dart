import 'package:flutter/material.dart';

import '../../../main_theme.dart';
import '../../../widgets/todo_form.dart';
import 'header_clipper.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  var isFlightselected = true;
  final TextEditingController _titleController = TextEditingController(text: 'To-Do Quick Add');

  onOpenFormDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return TodoForm(title: _titleController.text);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
            height: height * .25 < 150 ? height * .25 : 150,
            width: width,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                  colors: [
                    mainTheme.primaryColor,
                    mainTheme.secondaryHeaderColor
                  ]),
              shape: HeaderClipper(),
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 18.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.05,
                ),
                const Text(
                  'MY TODO',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: _titleController,
                      onTap: (){
                        _titleController.selection = TextSelection(baseOffset: 0, extentOffset: _titleController.text.length);
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: mainTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15, left: 15),
                          suffixIcon: Material(
                            color:
                                mainTheme.secondaryHeaderColor.withAlpha(230),
                            child: InkWell(
                              child: Icon(
                                Icons.add_alarm_sharp,
                                color: Colors.white,
                              ),
                              onTap: () {
                              onOpenFormDialog();
                              },
                            ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(25),
                            ),
                          )),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            "Oncoming",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            "see all",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
