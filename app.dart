import 'dart:io';

import 'windows1251Decoder.dart';
//String path = './lib/win1251ru.txt';
//
//var decoder =  windows1251Decoder(path).result;
//print(decoder);

class ScrubberDDS {

  String pathToDDS;

  ScrubberDDS(String pathToDDS){
    this.pathToDDS = pathToDDS;
    read();
  }

  read() {
    var decoder = new windows1251Decoder(pathToDDS);
//    print(decoder.result);
  }

//  Fields.csv
//Fields
  createFields(){

  }
//Fields
}

main(){

  String path = './1Cv7.DDS';

  new ScrubberDDS(path);

//  print(123);
}