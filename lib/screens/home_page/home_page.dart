import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/categories_view.dart';
import 'package:admin_panel/screens/home_page/widgets/single_dash_item.dart';
import 'package:admin_panel/screens/notification_screen/notification_screen.dart';
import 'package:admin_panel/screens/order_list/order_list.dart';
import 'package:admin_panel/screens/product_view/product_view.dart';
import 'package:admin_panel/screens/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dashboard')),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      "Ahmad salame",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "salamea015@gmail.com",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    ElevatedButton(onPressed: (){
                       Routes.instance.push(
                                widget: const NotificationScreen(), context: context);

       /* to find device token             
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
  });*/

                      
                    },
                     child: const Text("Send Notification to all users")),
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(top: 12.0),
                      crossAxisCount: 2,
                      children: [
                        SingleDashItem(
                          subtitle: "Users",
                          onPressed: () {
                            Routes.instance.push(
                                widget: const UserView(), context: context);
                          },
                          title: appProvider.getUserList.length.toString(),
                        ),
                        SingleDashItem(
                          subtitle: "Categories",
                          onPressed: () {
                            Routes.instance.push(
                                widget: const CategoriesView(),
                                context: context);
                          },

                          title:
                              appProvider.getCategoriesList.length.toString(),
                          // title: "2",
                        ),
                        SingleDashItem(
                          subtitle: "products",
                          onPressed: () {
                            Routes.instance.push(
                                widget: const ProductView(),
                                context: context);
                          },
                          title: appProvider.getProducts.length.toString(),
                        ),
                        SingleDashItem(
                          subtitle: "Earning",
                          onPressed: () {},
                          title: "\$${appProvider.getTotalEarning}",
                        ),
                        SingleDashItem(
                          subtitle: "Pending Order",
                          onPressed: () {
                              Routes.instance.push(
                                widget:  const OrderList(
                                  title: "Pending",
                                ), context: context);
                          },
                          title: appProvider.getPendingOrderList.length.toString(),
                        ),

                          SingleDashItem(
                          subtitle: "Delivery Order",
                          onPressed: () {
                               Routes.instance.push(
                                widget:  const OrderList(
                                  title: "Delivery",
                                ), context: context);
                          },
                          title: appProvider.getDeliveryOrderList.length.toString(),
                        ),
                           SingleDashItem(
                          subtitle: "Cancel Order",
                          onPressed: () {
                               Routes.instance.push(
                                widget:  const OrderList(
                                  title: "Cancel",
                                ), context: context);
                          },
                          title: appProvider.getCancelOrderList.length.toString(),
                        ),

                        SingleDashItem(
                          subtitle: "Completed Order",
                          onPressed: () {
                              Routes.instance.push(
                                widget:  const OrderList(
                                  title: "Completed",
                                ), context: context);
                          },
                          title: appProvider.getCompletedOrderList.length.toString(),
                        ),
                     
                      
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
