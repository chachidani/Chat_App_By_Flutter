import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Create a list of controllers for each input field
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose all controllers when the screen is closed
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff78b7d0),
        elevation: 0,
        title: Text(
          'Verify ${widget.phoneNumber}',
          style: const TextStyle(
            color: Color(0xFF16325B),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF16325B)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.more_vert,
            color: Color(0xFF16325B),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'We have sent an SMS with a code to',
              style: TextStyle(fontSize: 14, color: Color(0xFF16325B)),
            ),
            const SizedBox(height: 5),
            Text(
              widget.phoneNumber,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                // Add your "change number" logic here
              },
              child: const Text(
                'Wrong number?',
                style: TextStyle(color: Color(0xFF16325B)),
              ),
            ),
            const SizedBox(height: 40),
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => _otpTextField(index)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, color: const Color(0xFF16325B)),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Resend SMS logic
                  },
                  child: const Text(
                    'Resend SMS',
                    style: TextStyle(color: Color(0xFF16325B)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call, color: const Color(0xFF16325B)),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Call me logic
                  },
                  child: const Text(
                    'Call me',
                    style: TextStyle(color: Color(0xFF16325B)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(int index) {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: _otpControllers[index],  // Each field has its own controller
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        onChanged: (value) {
          // Automatically move to the next field after entering a digit
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
