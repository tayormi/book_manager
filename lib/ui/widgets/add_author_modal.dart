import 'package:book_manager/services/entities/author.dart';
import 'package:book_manager/services/isar_service.dart';
import 'package:flutter/material.dart';

class AddAuthorModal extends StatefulWidget {
  const AddAuthorModal({
    Key? key,
    required this.isarService,
  }) : super(key: key);

  final IsarService isarService;

  @override
  State<AddAuthorModal> createState() => _AddAuthorModalState();
}

class _AddAuthorModalState extends State<AddAuthorModal> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Text(
              'Add Author',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final author = Author()
                    ..firstName = _firstNameController.text
                    ..lastName = _lastNameController.text;
                  widget.isarService.createAuthor(author);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Author'),
            ),
          ]),
        ));
  }
}
