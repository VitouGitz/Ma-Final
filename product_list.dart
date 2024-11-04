import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importing HTTP package for API calls
import 'dart:convert'; // Importing JSON package for decoding API responses
import 'detail_screen.dart'; // Importing the Detail Screen

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List products = []; // List to store fetched product data
  bool isLoading = true; // Loading indicator flag

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products when the screen is initialized
  }

  // Fetch product list from the API
  fetchProducts() async {
    var url = 'https://fakestoreapi.com/products'; // API URL for fetching products
    var response = await http.get(Uri.parse(url)); // Making GET request to API

    // If the response is successful
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body); // Decode the JSON response
      setState(() {
        products = jsonResponse; // Set the products data
        isLoading = false; // Turn off the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Product List'), // App Bar with title "Product List"
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          childAspectRatio: 0.75, // Adjust item aspect ratio
        ),
        itemCount: products.length, // Number of products
        itemBuilder: (context, index) {
          var product = products[index]; // Access each product

          // Widget for each product card
          return GestureDetector(
            onTap: () {
              // Navigate to DetailScreen when product is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(productId: product['id']),
                ),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.network(
                    product['image'], // Display product image
                    height: 100,
                    width: 100,
                  ),
                  Text(product['title'],
                      overflow: TextOverflow.ellipsis), // Display product title
                  SizedBox(height: 15,),
                  Text('${product['price'].toString()} \$',style: TextStyle(fontSize: 20,color: Colors.red),), // Display product price
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.favorite,color: Colors.red,),
                      Icon(Icons.add_shopping_cart_rounded,color: Colors.orange,)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
