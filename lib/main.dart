import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/main_theme.dart';
import 'blocs/todo_bloc.dart';
import 'blocs/todo_event.dart';
import 'pages/list/list_page.dart';
import 'pages/recommend/recommend_page.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodosBloc()..add(LoadTodos()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MY TODO',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainLayout()),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final pages = [const RecommendPage(), const ListPage()];
  int currentPage = 0;

  List<BottomNavigationBarItem> menuBarLists() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.timer,
          color: mainTheme.secondaryHeaderColor,
        ),
        icon: Icon(
          Icons.timer,
          color: Colors.grey.shade400,
        ),
        label: "Today"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.list_alt_outlined,
          color: mainTheme.secondaryHeaderColor,
        ),
        icon: Icon(
          Icons.list_alt_outlined,
          color: Colors.grey.shade400,
        ),
        label: "All Todo"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages.elementAt(currentPage),
        bottomNavigationBar: BottomNavigationBar(
          items: menuBarLists(),
          iconSize: 28,
          selectedFontSize: 15,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.black,
          selectedItemColor: mainTheme.secondaryHeaderColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentPage,
          elevation: 1.5,
          onTap: (int index) {
            if (index != currentPage) {
              setState(() {
                currentPage = index;
              });
            }
          },
        ));
  }
}
