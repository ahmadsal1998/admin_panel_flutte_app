import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/product_view/edit_product/edit_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../models/product_model/product_model.dart';

class SingleProductView extends StatefulWidget {
  final ProductModel singleProduct;
  final int index;

  const SingleProductView({
    super.key,
    required this.singleProduct, required this.index,
  });



  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  
  @override


  Widget build(BuildContext context) {
      AppProvider appProvideer = Provider.of<AppProvider>(
    context,
    );
    return Card(
    color: Theme.of(context).primaryColor.withOpacity(0.3),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        //   alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Image.network(
                  widget.singleProduct.image,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.singleProduct.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Price: \$${widget.singleProduct.price}"),
              ],
            ),
          ),
            Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                       await appProvideer
                            .deleteProductsFromFirebase(widget.singleProduct);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () {

                      Routes.instance.push(
                        widget: EditProduct(
                          productModel: widget.singleProduct,
                          index: widget.index,),
                         context: context);

                    },
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    width: 12.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
