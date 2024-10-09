import 'package:flutter/material.dart';

class OwnMessegeCard extends StatelessWidget {
  final String message;
  final String time;
  OwnMessegeCard({super.key, required this.message  , required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Card(
          color: const Color(0xFFDCF8C6),
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
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
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
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Text(
                        time.substring(11 , 16),
                        style: TextStyle(
                          color: const Color(0xFF075E54),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.done_all,
                        color: const Color(0xFF075E54),
                        size: 20,
                      ),
                    ],
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
