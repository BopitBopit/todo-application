import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_event.dart';
import 'package:todo_app/pages/recommend/widgets/header_widget.dart';
import '../../blocs/todo_bloc.dart';
import '../../blocs/todo_state.dart';
import '../../widgets/todo_card.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  @override
  void initState() {
    super.initState();
  }

  List<TodoCard> todoLists = [];

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Positioned(
          top: height * 0.20,
          bottom: 0.0,
          child: SizedBox(
            height: height,
            width: width,
            child: BlocBuilder(
                bloc: todosBloc,
                builder: (BuildContext context, TodosState state) {
                  if (state is TodosLoading) {
                    return const Center(child: Text('To-Do Nothing'));
                  } else if (state is TodosLoaded) {
                    List<TodoCard> todoLists =
                        state.todosOncoming.map((e) => TodoCard(detail: e)).toList();                   
                      return ListView.builder(
                          itemBuilder: (context, index) => todoLists[index],
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 15),
                          itemCount: todoLists.length,
                          scrollDirection: Axis.vertical);
                  
                  } else {
                    return const Center(child: Text('To-Do Nothing'));
                  }
                }),
          ),
        ),
        const HeaderWidget(),
      ]),
    );
  }
}
