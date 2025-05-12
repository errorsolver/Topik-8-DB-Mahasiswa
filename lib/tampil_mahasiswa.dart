import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topik_8_db_mahasiswa/widget/create_mhs.dart';
import 'package:topik_8_db_mahasiswa/widget/delete_mhs.dart';
import 'package:topik_8_db_mahasiswa/widget/update_mhs.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: TampilDataMhs()));
}

class TampilDataMhs extends StatefulWidget {
  const TampilDataMhs({super.key});

  @override
  State<TampilDataMhs> createState() => _TampilDataMhsState();
}

class _TampilDataMhsState extends State<TampilDataMhs> {
  List mhsData = [];
  String address = '192.168.41.208';

  Future<void> bacaData() async {
    String uri = 'http://$address/koneksimhs.php';

    try {
      final res = await http.get(Uri.parse(uri));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          mhsData = data;
        });
      } else {
        print("Server error: ${res.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        mhsData = [];
      });
    }
  }

  @override
  void initState() {
    bacaData();
    super.initState();
  }

  void _showCreatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateMhs(onUpdate: bacaData),
    );
  }

  void _showUpdatePopup(
    BuildContext context,
    String nim,
    String name,
    String sex,
    String enroll,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => UpdateMhs(
            mhsData: mhsData,
            nim: nim,
            name: name,
            sex: int.parse(sex),
            enroll: int.parse(enroll),
            onUpdate: bacaData,
          ),
    );
  }

  void _showDeletePopup(
    BuildContext context,
    String nim,
    String name,
    String sex,
    String enroll,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => DeleteMhs(
            mhsData: mhsData,
            nim: nim,
            name: name,
            sex: int.parse(sex),
            enroll: int.parse(enroll),
            onUpdate: bacaData,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview data mahasiswa'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showCreatePopup(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text('Create Mahasiswa'),
              ),
              SizedBox(width: 10),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mhsData.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(mhsData[index]['nim']),
                        subtitle: Text(mhsData[index]['name']),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showUpdatePopup(
                          context,
                          mhsData[index]['nim'],
                          mhsData[index]['name'],
                          mhsData[index]['sex'],
                          mhsData[index]['enroll'],
                        );
                      },
                      child: Text('Update'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showDeletePopup(
                          context,
                          mhsData[index]['nim'],
                          mhsData[index]['name'],
                          mhsData[index]['sex'],
                          mhsData[index]['enroll'],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // warna teks
                        backgroundColor: Colors.red, // warna tombol
                      ),
                      child: Text('Delete'),
                    ),
                    SizedBox(width: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
