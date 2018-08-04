import 'dart:io';

import 'encodingSheetWin1251.dart';

class windows1251Decoder {
  List sheet = encodingSheetWin1251;

  String path;
  List str;
  String result;

  windows1251Decoder(path) {
    this.path = path;
    this.read();
    this.decode();
  }

  void read() {
    this.str = File(path).readAsBytesSync();
  }

  void decode() {
    this.result = codeListToStr(str);
  }

  List searchCode(int code) {
    List res = [-1, ''];
    for (int i = 0; i < sheet.length; i++) {
      if ((sheet[i][0] as int) == code) {
        res = sheet[i];
      }
    }
    return res;
  }

  String codeToLetter(int code) {
    return searchCode(code)[1];
  }

  List searchLetter(String letter) {
    List res;
    for (int i = 0; i < sheet.length; i++) {
      if ((sheet[i][1] as String) == letter) {
        res = sheet[i];
      }
    }
    return res;
  }

  int letterToCode(String letter) {
    return searchLetter(letter)[0];
  }

  String codeListToStr(List code) {
    String s = "";
    for (int i = 0; i < code.length; i++) {
      s += codeToLetter(code[i]);
      print(1);
    }
    return s;
  }
}
