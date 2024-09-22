import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('terms of use',style: TextStyle(color: Colors.white
        ),),
        backgroundColor: TTthemeClass().ttThird,
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'terms and Use for Travio',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Last updated: September 21, 2024',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'This Terms and use describes Our policies and procedures on the collection, use, '
                'and disclosure of Your information when You use the Service and tells You about '
                'Your privacy rights and how the law protects You.\n\n'
                'We use Your Personal data to provide and improve the Service. By using the Service, '
                'You agree to the collection and use of information in accordance with this Privacy Policy.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
              ),
              SizedBox(height: 20),
              Text(
                'Interpretation and Definitions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Interpretation:\n\n'
                'The words of which the initial letter is capitalized have meanings defined under  '
                'the following conditions. The following definitions shall have the same meaning '
                'regardless of whether they appear in singular or in plural.',
                style: TextStyle(fontSize: 16.0), 
              ),
              Text(
                'Definitions:\n\n'
                '- Account: A unique account created for You to access our Service.\n'
                '- Affiliate: Entity that controls, is controlled by, or is under common control with a party.\n'
                '- Application: Travio, the software program provided by the Company.\n'
                '- Company: Refers to Travio.\n'
                '- Country: Refers to Kerala, India.\n'
                '- Personal Data: Information that relates to an identified or identifiable individual.\n'
                '- Service: Refers to the Application.\n',
                style: TextStyle(fontSize: 16.0),
              ),
              
              SizedBox(height: 20),
              Text(
                'Collecting and Using Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Types of Data Collected:\n\n'
                'Personal Data:\n\n'
                'While using Our Service, we may ask You to provide Us with certain personally identifiable '
                'information that can be used to contact or identify You. This may include, but is not limited to, '
                'Email address, First name and last name, Phone number, Usage Data.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
              Text(
                'Usage Data:\n\n'
                'Usage Data is collected automatically when using the Service.:\n'
                "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n"
                'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n '
                'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
                style: TextStyle(fontSize: 16.0),
              ),
              // Add more sections as needed, following the same pattern.
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions about this Privacy Policy, you can contact us:\n\n'
                'By email: mshabeel999@gmail.com',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}