import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateMhs extends StatefulWidget {
  const CreateMhs({super.key, required this.onUpdate});

  final VoidCallback onUpdate;

  @override
  State<CreateMhs> createState() => _CreateMhsState();
}

class _CreateMhsState extends State<CreateMhs> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController enrollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create Mahasiswa"),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
              hintText: 'ex: 00001',
            ),
            controller: nimController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              hintText: 'ex: Ronald',
            ),
            controller: nameController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Sex',
              border: OutlineInputBorder(),
              hintText: 'ex: 0: Laki-laki, 1: Perempuan',
            ),
            controller: sexController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enroll',
              border: OutlineInputBorder(),
              hintText: 'ex: 2025',
            ),
            controller: enrollController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await createData();
            widget.onUpdate();
            Navigator.of(context).pop();
          },
          child: Text("Confirm"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }

  List mhsData = [];
  String address = '192.168.41.208';

  Future<void> createData() async {
    String uri = 'http://$address/koneksimhs.php';

    try {
      final res = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'nim': nimController.text,
          'name': nameController.text,
          'sex': sexController.text,
          'enroll': enrollController.text,
        },
      );

      if (res.statusCode != 200) {
        print("Server error: ${res.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
