import 'package:flutter/material.dart';

class WellcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background images
          Positioned(
            top: 0,
            right: 0,
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: Image.asset('assets/wellcome2.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: Image.asset('assets/wellcome3.png', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Image.asset('assets/wellcome1.png', fit: BoxFit.cover),
          ),
          // The button
          Positioned(
            bottom: 100, // Adjust this value to position the button vertically
            left: MediaQuery.of(context).size.width * 0.2, // Center the button horizontally
            right: MediaQuery.of(context).size.width * 0.2, // Center the button horizontally
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
                // Define your action here
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white.withOpacity(0.2), // Semi-transparent background
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Soft shadow
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Start Ur Conversation',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color is white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}