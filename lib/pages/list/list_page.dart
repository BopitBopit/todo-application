import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/todo_bloc.dart';
import '../../blocs/todo_state.dart';
import '../../widgets/todo_card.dart';
import 'widgets/top_bar.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<TodoCard> todoLists = [];

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height * 0.1 < 60 ? height * 0.1 : 60),
          child: const TopBar()),
      body: BlocBuilder(
          bloc: todosBloc,
          builder: (BuildContext context, TodosState state) {
            if (state is TodosLoading) {
              return const Center(child: Text('To-Do Nothing'));
            } else if (state is TodosLoaded) {
              List<TodoCard> todoLists =
                  state.todos.map((e) => TodoCard(detail: e)).toList();
                  if(todoLists.isNotEmpty){ 
                return ListView.builder(
                    itemBuilder: (context, index) => todoLists[index],
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: todoLists.length,
                    scrollDirection: Axis.vertical);
              }else{
                return const Center(child: Text('Not found'));
              }
            } else {
              return const Center(child: Text('To-Do Nothing'));
            }
          }),
    );
  }
}
