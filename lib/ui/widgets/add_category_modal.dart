import 'package:book_manager/services/entities/book_category.dart';
import 'package:book_manager/services/isar_service.dart';
import 'package:flutter/material.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({
    Key? key,
    required this.isarService,
  }) : super(key: key);

  final IsarService isarService;

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Category',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final category = BookCategory()
                      ..title = _textController.text;
                    widget.isarService.createBookCategory(category);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Category'),
              ),
            ],
          ),
        ));
  }
}
