import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  final String message;
  final String time;

  const ReplyMessageCard({super.key , required this.message , required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(
            top: 2,
            bottom: 8,
            right: 2,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message,
                  style: TextStyle(
                    color: const Color(0xFF075E54),
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    time.substring(11 , 16),

                    style: TextStyle(
                      color: const Color(0xFF075E54),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
