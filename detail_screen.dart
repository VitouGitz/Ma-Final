import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import HTTP package for API calls
import 'dart:convert'; // Import JSON package for decoding API responses

class DetailScreen extends StatefulWidget {
  final int productId; // Product ID passed from the Product List screen

  DetailScreen({required this.productId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var productDetails; // Variable to hold product details
  bool isLoading = true; // Loading indicator flag

  @override
  void initState() {
    super.initState();
    fetchProductDetails(); // Fetch product details when the screen is initialized
  }

  // Fetch product details from the API using the product ID
  fetchProductDetails() async {
    var url = 'https://fakestoreapi.com/products/${widget.productId}'; // API URL for fetching a specific product by ID
    var response = await http.get(Uri.parse(url)); // Making GET request to API

    // If the response is successful
    if (response.statusCode == 200) {
      setState(() {
        productDetails = json.decode(response.body); // Decode JSON response
        isLoading = false; // Turn off the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Product Details'), // App Bar with title "Product Details"
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(productDetails['image'], height: 150), // Display product image
            SizedBox(height: 16),
            Text(productDetails['title'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Display product title
            SizedBox(height: 16),
            Text(productDetails['description'],style: TextStyle(fontSize: 12),), // Display product description
            SizedBox(height: 150),
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Total :',style: TextStyle(fontSize: 20),),
                Text('${productDetails['price'].toString()} \$',
                    style: TextStyle(fontSize: 20, color: Colors.red)), // Display product price
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Action when button is pressed
                  },
                  label: Text("Check Out",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // To make the button rectangular
                  ), // Text and icon color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
