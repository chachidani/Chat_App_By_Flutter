import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/country_model.dart';
import 'package:mychat/features/chat/presentation/pages/country_page.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String Countryname = 'Ethiopia';
  String Countrycode = '+251';
  String Countryflag = '🇪🇹';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff78b7d0),
        elevation: 0,
        title: const Text(
          'Enter your phone number',
          style: TextStyle(
              color: Color(0xFF16325B),
              fontWeight: FontWeight.w700,
              fontSize: 18,
              wordSpacing: 1),
        ),
        centerTitle: true,
        actions: [
          const Icon(Icons.more_vert, color: Color(0xFF16325B)),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'MyChat will send an SMS message to verify your number',
              style: TextStyle(
                  color: Color(0xFF16325B),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Whats my number',
                style: TextStyle(
                    color: Color(0xFF16325B),
                    fontSize: 12.8,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1)),
            const SizedBox(
              height: 20,
            ),
            countryCard(),
            const SizedBox(
              height: 10,
            ),
            number(),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryPage(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff78b7d0),
          border: const Border(
              bottom: BorderSide(color: Color(0xFF16325B), width: 1.8)),
        ),
        child: Row(
          children: [
            Text(
              Countryflag,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '$Countryname ',
                style: const TextStyle(
                  color: Color(0xFF16325B),
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF16325B),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff78b7d0),
        border: const Border(
            bottom: BorderSide(color: Color(0xFF16325B), width: 1.8)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Countrycode,
              style: const TextStyle(
                color: Color(0xFF16325B),
                fontSize: 16.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: 'Phone Number',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel country) {
    setState(() {
      Countryname = country.name;
      Countrycode = country.code;
    });
    Navigator.pop(context);
  }
}
