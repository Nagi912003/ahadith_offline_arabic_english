import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../constants/all_ahadith.dart';
// import 'search_algorithm.dart';

class SearchProvider with ChangeNotifier {
  List<Map<String, dynamic>> Ahadith = allAhadith;
  final Box _savedBox = Hive.box('saved');

  // InvertedIndex index_ar = InvertedIndex();
  // InvertedIndex index_en = InvertedIndex();

  // void buildInvertedIndex() {
  //   List AhadithList_ar = Ahadith.map((e) => e["hadith_text_ar"]!).toList();
  //   index_ar.buildIndex(AhadithList_ar, 'ar');
  //
  //   List AhadithList_en = Ahadith.map((e) => e["hadith_text"]!).toList();
  //   index_en.buildIndex(AhadithList_en, 'en');
  // }

  // List<Map<String, dynamic>> searchByHadeeth(String query, String lang) {
  //   if (lang == 'ar') {
  //     List<Ranking> rankings = index_ar.rank(query, 10, 'ar');
  //     List<Map<String, dynamic>> searchResult = [];
  //
  //     for (Ranking ranking in rankings) {
  //       searchResult.add(Ahadith[ranking.docId]);
  //     }
  //
  //     return searchResult;
  //   } else
  //   // if (lang == 'en')
  //   {
  //     List<Ranking> rankings = index_en.rank(query, 10, 'en');
  //     List<Map<String, dynamic>> searchResult = [];
  //
  //     for (Ranking ranking in rankings) {
  //       searchResult.add(Ahadith[ranking.docId]);
  //     }
  //
  //     return searchResult;
  //   }
  // }

  Map<dynamic, dynamic> get dailyHadith {
    if (didDateChange()) {
      if (!_savedBox.containsKey('randomAhadith')) {
        int index = Random().nextInt(Ahadith.length);
        _savedBox.put('randomAhadith', [index]);
        return Ahadith[index];
      }

      int index = Random().nextInt(Ahadith.length);
      Map<String, dynamic> hadith = Ahadith[index];

      var randomAhadith = _savedBox.get('randomAhadith', defaultValue: []);

      while (randomAhadith.contains(index)) {
        index = Random().nextInt(Ahadith.length);
        hadith = Ahadith[index];
      }
      randomAhadith.add(index);

      _savedBox.put('randomAhadith', randomAhadith);

      _savedBox.put('randomHadith', hadith);
      return hadith;
    }
    if (!_savedBox.containsKey('randomHadith')) {
      int index = Random().nextInt(Ahadith.length);
      _savedBox.put('randomAhadith', [index]);
      _savedBox.put('randomHadith', Ahadith[index]);
    }
    final hadith = _savedBox.get('randomHadith', defaultValue: {});

    return hadith;
  }

  List<Map<String, dynamic>> get dailyAhadith {
    final indexList = _savedBox.get('randomAhadith', defaultValue: []);
    List<Map<String, dynamic>> dailyAhadith = [];
    for(var index in indexList){
      dailyAhadith.add(Ahadith[index]);
    }
    return dailyAhadith;
  }

  bool didDateChange() {
    if (!_savedBox.containsKey('date')) {
      _savedBox.put('date', DateTime.now());
      return true;
    }
    var date = DateTime.now();
    final savedDate = _savedBox.get('date');

    if (date.day != savedDate.day ||
        date.month != savedDate.month ||
        date.year != savedDate.year) {
      _savedBox.put('date', DateTime.now());
      return true;
    }
    return false;
  }
}
