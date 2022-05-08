import 'package:flutter/material.dart';
import '../../../main_theme.dart';
import '../../../widgets/todo_form.dart';
import '../../../widgets/todo_search_form.dart';
import '../../../widgets/todo_sort_form.dart';
import 'action_btn.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onOpenFormDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const TodoForm();
          });
    }

    onOpenSearchFormDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const TodoSearchForm();
          });
    }

    onOpenSortFormDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const TodoSortForm();
          });
    }
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;
    return Container(
        height: height * .25 < 150 ? height * .25 : 150,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: [
              mainTheme.primaryColor,
              mainTheme.secondaryHeaderColor
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Todo',
                    style: TextStyle(fontSize: 22.00, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                    child: GestureDetector(
                      onTap: () { onOpenSortFormDialog();},
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 18.00,
                          ),
                          Text("Sort/filter",
                              style: TextStyle(
                                 color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  ActionButton(icon: Icons.search,onAction: () => onOpenSearchFormDialog()),
                  const SizedBox(width: 5),
                  ActionButton(icon: Icons.add_alarm_sharp,onAction: () => onOpenFormDialog()),
                ],
              ),
            )
          ],
        ));
  }
}
