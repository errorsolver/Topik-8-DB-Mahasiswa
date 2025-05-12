import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateMhs extends StatefulWidget {
  const UpdateMhs({
    super.key,
    required this.mhsData,
    required this.nim,
    required this.name,
    required this.sex,
    required this.enroll,
    required this.onUpdate,
  });

  final List mhsData;
  final String nim;
  final String name;
  final int sex;
  final int enroll;
  final VoidCallback onUpdate;

  @override
  State<UpdateMhs> createState() => _UpdateMhsState();
}

class _UpdateMhsState extends State<UpdateMhs> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController enrollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nimController.text = widget.nim;
    nameController.text = widget.name;
    sexController.text = widget.sex.toString();
    enrollController.text = widget.enroll.toString();

    return AlertDialog(
      title: Text("Update Mahasiswa"),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'NIM',
              enabled: false,
              border: OutlineInputBorder(),
            ),
            controller: nimController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            controller: nameController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Sex',
              border: OutlineInputBorder(),
            ),
            controller: sexController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enroll',
              border: OutlineInputBorder(),
            ),
            controller: enrollController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await updateData();
            widget.onUpdate();
            Navigator.of(context).pop();
          },
          child: Text("Update"),
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

  Future<void> updateData() async {
    String uri = 'http://$address/koneksimhs.php';

    try {
      final res = await http.put(
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
