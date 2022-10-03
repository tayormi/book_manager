import 'package:book_manager/services/isar_service.dart';
import 'package:book_manager/ui/widgets/add_book_screen.dart';
import 'package:book_manager/ui/widgets/book_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Book Keeper'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: GestureDetector(
                onTap: () {}, child: const Icon(CupertinoIcons.delete)),
          )
        ],
      ),
      body: Row(children: [
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.white.withOpacity(0.1),
              child: AddBookScreen(
                isarService: isarService,
              ),
            )),
        Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: BookListScreen(
                isarService: isarService,
              ),
            )),
      ]),
    );
  }
}
