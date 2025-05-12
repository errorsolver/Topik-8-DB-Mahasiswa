import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteMhs extends StatefulWidget {
  const DeleteMhs({
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
  State<DeleteMhs> createState() => _DeleteMhsState();
}

class _DeleteMhsState extends State<DeleteMhs> {
  String address = '192.168.41.208';

  Future<void> deleteData(String nim) async {
    String uri = 'http://$address/koneksimhs.php?nim=$nim';

    try {
      final res = await http.delete(Uri.parse(uri));

      if (res.statusCode != 200) {
        print("Server error: ${res.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Mahasiswa"),
      content: Text(
        'Confirm deletion:\nNIM: ${widget.nim}\nNama: ${widget.name}\nSex: ${widget.sex}\nEnroll: ${widget.enroll}',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Batal"),
        ),
        TextButton(
          onPressed: () async {
            await deleteData(widget.nim);
            widget.onUpdate();
            Navigator.of(context).pop();
          },
          child: Text("Hapus"),
        ),
      ],
    );
  }
}
