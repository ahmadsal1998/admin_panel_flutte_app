import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/models/user_model/user_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/add_category/add_category.dart';
import 'package:admin_panel/screens/categories_view/widgets/single_category_item.dart';
import 'package:admin_panel/screens/user_view/widgets/single_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories View"),
        actions: [
          IconButton(onPressed: () {
            Routes.instance.push(widget: const AddCategory(), context: context);
          }, icon: const Icon(Icons.add_circle)),
        ],
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: value.getCategoriesList.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          value.getCategoriesList[index];
                      return SingleCategoryItem(singleCategory: categoryModel,index: index,);
                      //    return SingleUserCard(
                      //    userModel: userModel,
                      //  index: index,
                      //);
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
