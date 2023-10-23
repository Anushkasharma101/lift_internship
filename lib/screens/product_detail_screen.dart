import "dart:convert";
import "dart:ui";
import "package:carousel_indicator/carousel_indicator.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import 'package:get/get.dart';

import "../Controller/AllproductData_controller.dart";
import "../Models/AllproductsData.dart";

class ProductDetailScreen extends StatefulWidget {
  int productId;
  ProductDetailScreen({required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? productDetails;
  late AllProductDataController controller;
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    controller = Get.find<AllProductDataController>();
    super.initState();
  }

  Future<Product?> fetchProductDetails(int productId) async {
    try {
      final product = await controller.fetchProductDetails(productId);
      setState(() {
        product.title;
      });

      return product;
    } catch (e) {
      print('Error: $e');
      return null; // Return null in case of an error
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: fetchProductDetails(widget.productId),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return
              SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: ListView(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: snapshot.data!.images.map((imagePath) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: NetworkImage(imagePath),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * 0.4,
                                viewportFraction: 1.0, // Display one item at a time
                                autoPlay: false,
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
                          SizedBox(
                            height: 8,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CarouselIndicator(
                                index: _currentIndex, // Use the same controller for synchronization
                                count: snapshot.data!.images.length, // Number of items in the carousel
                                color: Colors.grey.shade200, // Inactive dot color
                                activeColor: Colors.grey, // Active dot color
                                height: 10, // Height of the dots
                                width: 10,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                                child: SizedBox(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, icon: Icon(Icons.arrow_back_ios)),
                                      Spacer(),
                                      Text("Details",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width*0.05,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Spacer(),
                                      IconButton(onPressed: (){},
                                          icon: Icon(Icons.favorite_border))
                                    ],
                                  ),
                                )
                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.03,right: width*0.03,top: height*0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data!.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('\$ ${snapshot.data!.price}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.03,right: width*0.03,),
                        child: Text(snapshot.data!.description,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: width*0.035
                          ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.03,right: width*0.03,top: height*0.03),
                        child: Text('Color Available',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            )),
                      ),
                      Container(
                        height: width*0.2,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal, // Scroll horizontally
                            itemCount: snapshot.data!.images.length, // Number of items in the list
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(10.0),
                                width: width*0.15, // Set the desired width
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black), // Black border
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data!.images[index]),
                                    // Replace with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.only(left: width*0.03,right: width*0.03,bottom: height*0.02),
                    height: height*0.08,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width,
                          height: height*0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Buy now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ),
              );
          }else{
            return
              const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }
}
