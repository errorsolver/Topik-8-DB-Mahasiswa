import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> bacaData() async {
    String uri = 'http://192.168.1.20/koneksimhs.php';

    try {
      final res = await http.get(Uri.parse(uri));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          mhsData = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    bacaData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Listview data mahasiswa')),
        body: ListView.builder(
          itemCount: mhsData.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                ListTile(
                  title: Text(mhsData[index]['nim']),
                  subtitle: Text(mhsData[index]['nama_mhs']),
                ),
                ElevatedButton(onPressed: () {}, child: Text('Update')),
                ElevatedButton(onPressed: () {}, child: Text('Delete')),
              ],
            );
          },
        ),
      ),
    );
  }
}
