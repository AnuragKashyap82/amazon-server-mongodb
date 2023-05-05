import 'package:amazon/features/home/widgets/adderss_box.dart';
import 'package:amazon/features/home/widgets/carousel_images.dart';
import 'package:amazon/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon/features/home/widgets/top_categories.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_varibales.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    
    void navigateToSearchScreen(String query){
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: (){
                                
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                              ),
                            ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none
                          ),
                          enabledBorder:  const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.black38, width: 1)
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )
                        ),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25,),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
             SizedBox(
              height: 10,
            ),
            TopCategories(),
            SizedBox(
              height: 10,
            ),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
