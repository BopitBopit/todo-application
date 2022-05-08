class TodoListModel {
  List<TodoModel>? todo;

  TodoListModel({this.todo});

  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
        todo: (json['data'] as List<dynamic>?)
            ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() =>
      {'data': todo?.map((e) => e.toJson()).toList()};
}


class TodoModel{
  String id;
  String title;
  String? description;
  String? image;
  String status;
  String date;

  TodoModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.status,
      this.description,
      this.image});

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        date = json['date'],
        status = json['status'],
        description = json['description'],
        image = json['image'];

  Map<String, dynamic> toJson() => {        
        'id': id,
        'title' : title,
        'date' : date,
        'status' : status,
        'description' : description,
        'image' : image,
      };
}