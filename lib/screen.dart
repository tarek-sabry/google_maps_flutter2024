import 'package:flutter/material.dart';

class ImageAndTextScreen extends StatelessWidget {
  const ImageAndTextScreen({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image and Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://img.freepik.com/free-vector/ecommerce-web-page-concept-illustration_114360-8204.jpg?t=st=1723221369~exp=1723224969~hmac=655d381a36cf95c6651e7135e86b1a7e87a81879fc49799b8ea6c1a0f158fb7a&w=1380'), // Replace with your image URL
            const SizedBox(height: 20),
            const Text(
              'Your text here',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}