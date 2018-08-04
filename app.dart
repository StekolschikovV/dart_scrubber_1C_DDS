import 'dart:io';

import 'windows1251Decoder.dart';

class ScrubberDDS {
  String pathDDS;
  String decodePath;
  String rawData;

  ScrubberDDS(String pathToDDS, String decodePath, {bool needDecode = false}) {
    this.pathDDS = pathToDDS;
    this.decodePath = decodePath;
    if (needDecode) {
      decode();
    }
    read();
    createFields();
    createTable();
  }

//  decode
  decode() {
    var decodeText = windows1251Decoder(pathDDS).result;
    new File(decodePath).writeAsStringSync(decodeText);
  }

//  decode

  read() {
    this.rawData = new File(decodePath).readAsStringSync();
  }

//  Fields
  createFields() {
    var s = this.rawData.split(
        "#===============================================================================");
    List<String> sClear = [];
    for (int i = 0; i < s.length; i++) {
      if (s[i].contains('#==TABLE no ')) {
        var cat = s[i].split('\n')[1].split(':')[1].trim().replaceAll(' ', '.');
        var temp = s[i].split('\n');
        var temp2 = false;
        for (int i = 0; i < temp.length; i++) {
          if (temp[i].contains('#----Indexes------')) {
            break;
          } else if (temp[i].contains('#-----Fields-------')) {
            temp2 = true;
          }
          if (!temp[i].contains('#') &&
              temp2 &&
              temp[i].split('|').length > 1) {
            sClear.add(
                "${cat} ${temp[i].split('|')[1].trim()} ${temp[i].split('|')[0].split('=')[1].trim()}");
          }
        }
      }
    }

    String str = 'СсылкаНаТаблицу	ИмяПоля	ИмяПоляХранения	Метаданные	ТипДБ	\n';
    for (int i = 0; i < sClear.length; i++) {
      str = str + sClear[i] + "\n";
    }
    new File('./result/Fields.csv').writeAsStringSync(str);
  }

//  Fields

//  tables
  createTable() {
    List<String> list = this.rawData.split('\n');
    String res = 'Метаданные	ИмяТаблицыХранения\n';
    for(int i = 0; i < list.length; i++){
      if (i > 3 && list[i - 2].contains('#==TABLE no')) {
        res = res + '${list[i].split('|')[1].trim().replaceAll(' ', '.')} ${list[i].split('|')[2].trim()}\n';
      }
    }
    new File('./result/tables.csv').writeAsStringSync(res);
  }
//  tables


}

main() {
  String path = './1Cv7.DDS';
  String decodePath = './1Cv7___UTF8.txt';

  new ScrubberDDS(path, decodePath, needDecode: false);
}
