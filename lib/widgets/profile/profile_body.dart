import 'package:flutter/material.dart';

class ProfileBody {
   ListView listView() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                height: 150,
                width: 150,
                color: Color(0xffFF0E58),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'User Name ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Text(
              'pronounciation',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              'username@gmail.com',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
              width: 360,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text('settings1'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('version'),
                  Text('1.01.001')
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ],
    );
  }
}