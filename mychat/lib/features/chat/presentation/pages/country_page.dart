import 'package:flutter/material.dart';
import 'package:mychat/core/dummy/listofcountry.dart';
import 'package:mychat/features/chat/data/models/country_model.dart';

class CountryPage extends StatefulWidget {
  
  const CountryPage({super.key , required this.setCountryData});
  final Function setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff78b7d0),
        title: const Text(
          'Choose a country ',
          style: TextStyle(
              color:
                  //pic primary color
                  Color(0xFF16325B),
              fontWeight: FontWeight.w700,
              fontSize: 18,
              wordSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF16325B),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF16325B)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return cauntCard(countries[index]);
        },
      ),
    );
  }

  Widget cauntCard(CountryModel country) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country);
      },
      child: Card(
        color: Color(0xff78b7d0),
        margin: EdgeInsets.all(0.5),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(country.flag),
              SizedBox(
                width: 15,
              ),
              Text(
                country.name,
              ),
              Spacer(),
              Text(country.code),
            ],
          ),
        ),
      ),
    );
  }

  
}
