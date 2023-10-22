import "dart:ui";

import "package:carousel_indicator/carousel_indicator.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}
class _ProductDetailScreenState extends State<ProductDetailScreen> {

  List<String> img = ["assets/images/ad1.png","assets/images/ad2.jpg","assets/images/ad3.jpg","assets/images/ad4.jpg"];
  int _currentIndex =0;
  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight - appBarHeight - 300.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset("assets/images/left.png"),
          color: Colors.black,
          onPressed: (){},
        ),
        title: Center(
            child: Text(
              'Details',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
              ),
        ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Image.asset("assets/images/heart.png"),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
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
              CarouselIndicator(
                index: _currentIndex, // Use the same controller for synchronization
                count: img.length, // Number of items in the carousel
                color: Colors.grey.shade200, // Inactive dot color
                activeColor: Colors.grey, // Active dot color
                height: 10, // Height of the dots
                width: 10,
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item 1',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Padding(padding:const EdgeInsets.all(8.0),
                child: Text('\$10',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text('Description'),
          SizedBox(height: 10,),
          Text('Color Available',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          )),
          Container(
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
            scrollDirection: Axis.horizontal, // Scroll horizontally
    itemCount: 4, // Number of items in the list
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.all(10.0),
        width: 70.0, // Set the desired width
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), // Black border
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage('https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg'),
              // Replace with your image path
              fit: BoxFit.fitHeight,
            ),
        ),
      );
    }
    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),

              child: Text('Buy now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                ),),
            ),
          ),
        ),
      ),

    );
  }
}
