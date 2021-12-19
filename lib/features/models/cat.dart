import 'package:flutter/material.dart';

class Photo {
  late String id;
  late String  photo_name;
  late String image_source;

  Photo(this.id, this.photo_name, @required this.image_source);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
      'image_source':image_source
    };
    return map;
  }

  Photo.fromMap(Map<dynamic, dynamic> map) {
    print(map);
    id = map['id'];
    photo_name = map['photo_name'];
    image_source = map['image_source'];

  }
}