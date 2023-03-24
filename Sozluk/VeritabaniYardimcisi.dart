import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class VeritabaniYardimcisi{

  static final String veritabaniAdi = "sozluk.sqlite";

  static Future<Database> VeritabaniErisim() async{
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("veritabanı zaten var, kopyalamaya gerek yok");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);

      print("veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);

  }
}

