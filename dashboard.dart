import 'package:flutter/material.dart';
import 'product_list.dart'; // Importing the Product List Screen

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Dashboard'), // Title for the dashboard app bar
        actions: [
          // Add any action icons like notifications (as seen in your image)
          IconButton(
            icon: Icon(Icons.notifications), // Notification icon on the app bar
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        // Optional: Drawer (side menu) can be implemented if needed
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more list items here if you want
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32), // Padding around the content

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First button (Point of Sale) with icon and text
                  DashboardButton(
                    icon: Icons.point_of_sale, // Icon resembling Point of Sale
                    label: 'POINT OF SALE', // Label under the icon
                    onTap: () {
                      // Action for Point of Sale button
                    },
                  ),
                  SizedBox(width: 16), // Space between buttons
                  // Second button (Product List) with icon and text
                  DashboardButton(
                    icon: Icons.list_alt, // Icon resembling Product List
                    label: 'Product List', // Label under the icon
                    onTap: () {
                      // Navigate to Product List screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductListScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

      ),
    );
  }
}

// Custom Widget for Dashboard buttons
class DashboardButton extends StatelessWidget {
  final IconData icon; // Icon for the button
  final String label; // Label under the icon
  final VoidCallback onTap; // On tap callback for the button

  const DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executes the provided onTap function when button is tapped
      child: Column(
        children: <Widget>[
          // Icon
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blue[50], // Light background color for the button
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Icon(
              icon, // Display provided icon
              size: 40,
              color: Colors.teal, // Custom icon color
            ),
          ),
          SizedBox(height: 8), // Space between icon and label
          // Text label under the icon
          Text(
            label,
            style: TextStyle(fontSize: 16), // Customize the font size
          ),
        ],
      ),
    );
  }
}
