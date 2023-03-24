import 'package:sozluk_uygulamasi/Sozluk/Kelimeler.dart';
import 'package:sozluk_uygulamasi/Sozluk/VeritabaniYardimcisi.dart';

class KelimelerDao {

  Future<List<Kelimeler>> tumKelimeler() async{
      var db = await VeritabaniYardimcisi.VeritabaniErisim();

      List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");

      return List.generate(maps.length, (i) {
        var satir = maps[i];
        return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
      });
  }

  Future<List<Kelimeler>> kelimeAra(String aramaKelimesi) async{
    var db = await VeritabaniYardimcisi.VeritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%${aramaKelimesi}%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }

}