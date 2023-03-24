// @dart=2.9
import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/Sozluk/DetaySayfa.dart';
import 'package:sozluk_uygulamasi/Sozluk/KelimelerDao.dart';

import 'Kelimeler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home:  Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kelimeler>> tumKelimelerGoster() async{
    var kelimelerListesi = await KelimelerDao().tumKelimeler();
    return kelimelerListesi;
  }

  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async{
    var kelimelerListesi = await KelimelerDao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
            TextField(
              decoration: InputDecoration(hintText: "Arama yapınız: "),
              onChanged: (aramaSonucu){
                print("Arama sonucu: $aramaSonucu");
                setState(() {
                  aramaKelimesi = aramaSonucu;
                });
              },
            )
       : Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
          onPressed: (){
          setState(() {
           aramaYapiliyorMu = false;
           aramaKelimesi = "";
           });
            },
            icon: Icon(Icons.cancel),
           )
          : IconButton(
              onPressed: (){
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
              icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
          future: aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKelimelerGoster(),
          builder: (context,snapshots){
            if(snapshots.hasData){
              var kelimelerListesi = snapshots.data;
              return ListView.builder(
                itemCount: kelimelerListesi.length,
                  itemBuilder: (context,indeks){
                  var kelime = kelimelerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kelime: kelime,)));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(kelime.turkce),
                          ],
                        ),
                      ),
                    ),
                  );
                  },
              );
            }else{
              return Center();
            }
          }
      ),

    );
  }
}
