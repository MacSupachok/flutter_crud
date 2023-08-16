import 'package:flutter/material.dart';
import 'package:flutter_crud_test/src/screens/edit_page.dart';
import 'package:flutter_crud_test/src/screens/insert_page.dart';
import 'package:flutter_crud_test/src/screens/view_page.dart';

class AppRoute {
  static const insert = 'insert';
  static const edit = 'edit';
  static const view = 'view';

  static get all => <String, WidgetBuilder>{
        insert: (context) => const InsertPage(),
        edit: (context) => EditPage(
              user: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        view: (context) => const ViewPage(),
      };
}
