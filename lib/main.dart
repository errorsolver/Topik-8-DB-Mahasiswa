import 'package:flutter/material.dart';
import 'package:topik_8_db_mahasiswa/tampil_mahasiswa.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: TampilDataMhs(),
    );
  }
}
