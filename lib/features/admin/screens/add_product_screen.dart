import 'dart:io';

import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textField.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_varibales.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: _productNameController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          quantity: double.parse(_quantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
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
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((i) {
                            return Builder(
                                builder: (BuildContext context) => Image.file(
                                      i,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ));
                          }).toList(),
                          options:
                              CarouselOptions(viewportFraction: 1, height: 200),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select Product Images",
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    )
                                  ],
                                ),
                              )),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      controller: _productNameController,
                      hintText: "Product Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _descriptionController,
                      hintText: "Description",
                      maxLines: 7),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _priceController, hintText: "Product Price"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _quantityController, hintText: "Quantity"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(text: "Sell", onTap: sellProduct),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
