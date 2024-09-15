import 'package:assign_app/Screens/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectCourierPage extends StatefulWidget {
  @override
  _SelectCourierPageState createState() => _SelectCourierPageState();
}

class _SelectCourierPageState extends State<SelectCourierPage> {

  // Function to show confirmation dialog
  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you really want to quit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
                // Alternatively, you can use exit(0); but it's not recommended for iOS.
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/arrow_back.png'),
          onPressed: () {
            // Navigator.pop(context);
            _showExitConfirmationDialog(context);}
        ),
        title: Text(
          'Select Courier',
          style: TextStyle(fontFamily: 'Supermercado', fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            // Background Map Image
            Positioned.fill(
              bottom: 40,
              child: Image.asset(
                'assets/images/map_img.png',
                fit: BoxFit.fill,
              ),
            ),
            // Green Location Pin
            Positioned(
              top: 302,
              left: 156,
              child: Icon(Icons.location_pin, size: 40, color: Colors.green),
            ),
            // Vector Line Image
            Positioned(
              top: 172,
              left: 150,
              child: Image.asset(
                'assets/images/vector.png',
                fit: BoxFit.scaleDown,
                width: 175,
                height: 180,
              ),
            ),
            // Red Location Pin
            Positioned(
              top: 137,
              right: 25,
              child: Icon(Icons.location_pin, size: 40, color: Colors.red),
            ),
            // Container with Options
            Positioned(
              bottom: 90, // Adjusted to leave space for the button
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Where is it going?',
                      style: TextStyle(
                        fontFamily: 'Supermercado',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/rectangle.png'),
                          onPressed: () {},
                        ),
                        Container(
                          width: 230,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0), // Padding inside the container
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(230, 255, 232,
                                1), // Light blue background color
                            borderRadius: BorderRadius.circular(
                                10), // Rounded corners with radius of 10
                          ),
                          child: const Text(
                            'Current location',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Image.asset('assets/images/vectorline.png'),
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/rectanglered.png'),
                          onPressed: () {},
                        ),
                        Container(
                          width: 230,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0), // Padding inside the container
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(230, 255, 232,
                                1), // Light blue background color
                            borderRadius: BorderRadius.circular(
                                10), // Rounded corners with radius of 10
                          ),
                          child: const Text(
                            'Choose recipients location',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Elevated Button at the Bottom
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  // Add continue action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 252, 133, 6),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Supermercado',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
