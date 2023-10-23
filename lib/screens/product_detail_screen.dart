import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_project/exandable_text_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0, // Set the top to 0 to position the image at the top
            left: 0,
            right: 0,
            child: CarouselSlider(
              options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.60,
              enableInfiniteScroll: true,
            ),
             items: [
               Container(
                 decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://www.lifewire.com/thmb/eRYc9pjbOb_tGDAznFfsRnMtu2E=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Board_EN-US-478ee9b2d264410c9290d435ebf424f7.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
             ],
            ),

          ),
          Positioned(
            top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: Image.asset("assets/images/left.png"),),
                  Center(child: Text('Details',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                  IconButton(onPressed: (){}, icon: Image.asset("assets/images/heart.png"),),
                ],
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.62,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item 1',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Text('\$10',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height * 0.65,
              left: 20,
              right: 20,
              child: Container(
                height: 200,
                child: Column(
                  children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpandableTextWidget(text: 'Users can make and receive phone calls, and some cellphones also offer text messaging.',
                    ),
                  ),
                ),
            ],
          ),
              ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.78 ,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Text('Color Available',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
          ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.80,
            left: 20,
            right: 20,
            child: Container(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 70.0,
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage('https://i.gadgets360cdn.com/products/large/iqoo-neo-7-5g-db-709x800-1676531196.jpg'),
                      fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                  }),
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
