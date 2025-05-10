import 'package:flutter/material.dart';

class UpdateMahasiswa extends StatelessWidget {
  const UpdateMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Listview data mahasiswa')),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
