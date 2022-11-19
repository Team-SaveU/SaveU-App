import 'package:flutter/material.dart';
import 'package:save_u/models/sub_category.dart';
import 'package:save_u/sevices/db_helper.dart';
import 'safe_infos_page.dart';

class SubCategoriesPage extends StatefulWidget {
  const SubCategoriesPage({super.key});

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Sub Categories'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            DBHelper.deleteDatabase("SaveU.db");
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<SubCategory>?>(
          future: DBHelper.getAllSubCategories(),
          builder: (context, AsyncSnapshot<List<SubCategory>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      Text(snapshot.data![index].name.toString()),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
