import 'dart:convert';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:demo_project/Models/AllproductsData.dart';
import 'package:demo_project/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Controller/AllproductData_controller.dart';

class HomeScreen extends StatefulWidget {
  final AllProductDataController controller;

  HomeScreen({Key? key, required this.controller}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<String> img = ["assets/images/ad1.png","assets/images/ad2.jpg","assets/images/ad3.jpg","assets/images/ad4.jpg"];
  int _currentIndex = 0;
  int _currentCatIndex = 0;
  bool seeAll = false;
  List<String> _data=[];
  @override
  void initState(){
    // TODO: implement initState
    _fetchData();
    super.initState();
  }

  Future<List<Product>> _fetchData() async {
    await widget.controller.fetchCategories();
    await widget.controller.fetchProductsByCategory(widget.controller.categories[0]);
    setState(() {
      _data = widget.controller.categories;

    });
    return widget.controller.products;

  }
  @override
  Widget build(BuildContext context) {
    final double height  = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (_data.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.02),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: width*0.07,
                              backgroundImage: AssetImage('assets/images/profile.png'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Krishna SN',
                                style: TextStyle(
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.notifications,
                            size: width*0.07,
                          ),
                          SizedBox(width: width * 0.03),
                          Icon(
                            Icons.menu,
                            size: width*0.07,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right:width * 0.03, left: width*0.03,top: height*0.03,bottom: height*0.03),
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500
                          ),
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Search for brand',
                          prefixIcon: Icon(Icons.search,color: Colors.grey.shade500,),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        CarouselSlider(
                          items: img.map((imagePath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.3,
                              viewportFraction: 1.0, // Display one item at a time
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false, // Do not enlarge the center item
                              onPageChanged: (index, reason){
                                setState(() {
                                  _currentIndex = index;
                                });
                              }
                          ),
                        ),
                        Positioned(
                          bottom: 10, // Position at the bottom
                          left: 0, // Position at the left
                          right: 0, // Position at the right
                          child: Center(
                            child: CarouselIndicator(
                              index: _currentIndex, // Use the same controller for synchronization
                              count: img.length, // Number of items in the carousel
                              color: Colors.grey.shade200, // Inactive dot color
                              activeColor: Colors.grey, // Active dot color
                              height: 10, // Height of the dots
                              width: 10,
                            ),
                          ),
                        ),

                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: width*0.03,top: height*0.03,),
                      height: height*0.07,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:  widget.controller.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async{
                              _currentCatIndex = index;
                              widget.controller.products.clear(); // Clear the existing products
                              await widget.controller.fetchProductsByCategory( widget.controller.categories[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: width*0.03),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: _currentCatIndex == index?Colors.black:Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: Text( widget.controller.categories[index],
                                  style: TextStyle(
                                      color: _currentCatIndex==index?Colors.white:Colors.grey.shade500
                                  ),),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.03, left: width*0.03,top: height*0.03,bottom: height*0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.controller.categories[_currentCatIndex],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ) ,),
                          GestureDetector(
                              onTap: ()=> setState(() {
                                seeAll = !seeAll;
                              }),
                              child: Text(seeAll?'See Less':'See All')),
                        ],
                      ),
                    ),
                    widget.controller.products.isEmpty?
                    Center(child: CircularProgressIndicator())
                        :buildProductGrid()

                  ]),
            ),
          )),
    );
  }

  Widget buildBannerAd(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 340,
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  Widget buildProductGrid() {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: seeAll
            ? widget.controller.products.length
            : widget.controller.products.length >= 2
            ? 2
            : widget.controller.products.length,
        itemBuilder: (context, index) {
          print("producttttttt......${widget.controller.products[0]}");
          return Padding(
            padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(productId: widget.controller.products[index].id),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.controller.products[index].images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.controller.products[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            widget.controller.products[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${widget.controller.products[index].price}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
