import 'package:amazon/common/widgets/loder.dart';
import 'package:amazon/features/home/service/home_services.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_varibales.dart';
import '../../../models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: TextStyle(fontSize: 16, color: Colors.black),
            )),
      ),
      body: productList == null ? const Loader() : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep shopping for ${widget.category}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
                itemCount: productList!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final product = productList![index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black12, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(product.images[0]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 5,
                            right: 15,
                          ),
                          child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
