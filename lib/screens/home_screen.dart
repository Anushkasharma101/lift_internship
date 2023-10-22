import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:demo_project/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> img = ["assets/images/ad1.png","assets/images/ad2.jpg","assets/images/ad3.jpg","assets/images/ad4.jpg"];
  int _currentIndex =0;
  bool seeAll = false;
  List<String> categories = ["All Product", "SmartPhone", "Wearable","Camera"];
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Item 1',
      'description':
      'This is a long description for Item 1. It should be truncated with an ellipsis.',
      'price': '\$10',
      'imageUrl': 'https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg',
    },
    {
      'title': 'Item 2',
      'description':
      'This is a long description for Item 2. It should be truncated with an ellipsis.',
      'price': '\$15',
      'imageUrl': 'https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg',
    },
    {
      'title': 'Item 1',
      'description':
      'This is a long description for Item 1. It should be truncated with an ellipsis.',
      'price': '\$10',
      'imageUrl': 'https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg',
    },
    {
      'title': 'Item 2',
      'description':
      'This is a long description for Item 2. It should be truncated with an ellipsis.',
      'price': '\$15',
      'imageUrl': 'https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg',
    },
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    final double height  = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
                          radius: 20,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Krishna SN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Search for brand',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
          Container(
            padding: EdgeInsets.only(left: 14,top: 14,bottom: 10),
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  child: Center(
                    child: Text(categories[index]),
                  ),
                );
              },
            ),
          ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('New Arrival',
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
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: seeAll ? items.length:2,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetailScreen()),
                      );
                    },
                    child: Card(

                      child: Column(
                        children: [
                          Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(items[index]['imageUrl']),
                                fit: BoxFit.fitHeight,
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  items[index]['description'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      items[index]['price'],
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
                                        borderRadius: BorderRadius.circular(5)
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
          ),

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
}
