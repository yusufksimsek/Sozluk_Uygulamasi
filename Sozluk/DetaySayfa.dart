import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/Sozluk/Kelimeler.dart';

class DetaySayfa extends StatefulWidget {

  late Kelimeler kelime;


  DetaySayfa({required this.kelime});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.kelime.ingilizce}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink,fontSize: 40),),
            Text("${widget.kelime.turkce}",style: TextStyle(fontSize: 35),),
          ],
        ),
      ),

    );
  }
}
