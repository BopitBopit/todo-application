import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/main_theme.dart';
import 'package:uuid/uuid.dart';

import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../models/todo_list_model.dart';

class TodoForm extends StatefulWidget {
  final String? title;
  final TodoModel? todo;
  const TodoForm({Key? key, this.todo, this.title}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late String id;
  late XFile _imageFile = XFile('');
  late String _imageBase64;

  DateTime dateNow = DateTime.now().toLocal();
  late DateTime selectedDate;
  bool isChecked = false;
  bool isTitleEmpty = false;

  @override
  void initState() {
    id = widget.todo?.id ?? const Uuid().v1();
    _titleController.text = widget.todo?.title ?? widget.title ?? '';
    _descriptionController.text = widget.todo?.description ?? '';
    selectedDate =
        DateFormat('yyyy-MM-dd').parse(widget.todo?.date ?? dateNow.toString());
    _dateController.text = DateFormat.yMd().format(selectedDate);
    _imageBase64 = widget.todo?.image ?? '';
    isChecked = ((widget.todo?.status ?? false) == false
        ? false
        : widget.todo?.status == 'COMPLETE'
            ? true
            : false);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 420,
        maxHeight: 600,
        imageQuality: 8,
      );
      setState(() {
        _imageFile = pickedFile!;
        final bytes = File(_imageFile.path).readAsBytesSync();
        _imageBase64 = base64Encode(bytes);
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodosBloc>(context);
    double height = MediaQuery.of(context).size.longestSide;
    return AlertDialog(
      content: Form(
          key: _formKey,
          child: SizedBox(
            height: height * 0.7,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Status"),
                      Checkbox(
                          value: isChecked,
                          onChanged: (checked) {
                            setState(() {
                              isChecked = checked!;
                            });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 70,
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          hintText: 'ex. Meeting Team ',
                          labelText: 'Title',
                          errorText: isTitleEmpty ? 'required' : null),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        hintText: 'ex. Meeting Team about solution topic',
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 55,
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: TextButton(
                            child: _imageFile.path.isEmpty
                                ? const Text('Upload Photo')
                                : const Text('Change Photo'),
                            style: TextButton.styleFrom(
                              primary: Colors.teal,
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.gallery,
                                  context: context);
                            },
                          ),
                        ),
                      ),
                      if (_imageBase64.isNotEmpty)
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: TextButton(
                              child: const Text('Delete Photo'),
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                                side: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  _imageFile = XFile('');
                                  _imageBase64 = '';
                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_imageBase64.isNotEmpty)
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.memory(base64Decode(_imageBase64))
                    ),
                ],
              ),
            ),
          )),
      title: Text('ADD TODO',
          style: TextStyle(color: mainTheme.secondaryHeaderColor)),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Text('SAVE', style: TextStyle(color: Colors.blue)),
            onTap: () {
              if (_titleController.text == '') {
                return setState(() {
                  isTitleEmpty = true;
                });
              }
              if (widget.todo != null) {
                  todoBloc.add(UpdateTodos(TodoModel(
                  id: id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: selectedDate.toIso8601String(),
                  image: _imageBase64,
                  status: isChecked ? 'COMPLETE' : 'IN_PROGRESS',
                ), false));
              } else {
                todoBloc.add(AddTodos(TodoModel(
                  id: id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: selectedDate.toIso8601String(),
                  image: _imageBase64,
                  status: isChecked ? 'COMPLETE' : 'IN_PROGRESS',
                )));
              }
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
