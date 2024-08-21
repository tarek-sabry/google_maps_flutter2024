import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('data'),),
      body: const Center(
        child: Column(
          children: [
            Text('Sponsored Images iStock'),
            SizedBox(
              height: 400,
              child: Flutter3DViewer(
                  src: 'assets/images/damaged_helmet.glb',
               ),
            )
          ],
        ),
      ),
    );
  }
}
