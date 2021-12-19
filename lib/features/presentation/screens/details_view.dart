import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stb_cat_app/features/models/detail_image.dart';

class ImageDetail extends StatelessWidget {

   const ImageDetail({required this.detailPage}) : super();


  final DetailPage detailPage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cat Detail image"),),
      body: SizedBox(
        width: double.infinity,
        child: Hero(
          tag: detailPage.tag ?? '',
          child:  detailPage.imageType =="url" ?

          Image.network(
            detailPage.image,
            fit: BoxFit.fill,
          ) :  Image.memory(
            const Base64Codec()
            .decode( detailPage.image),
          fit: BoxFit.fill,
        )
        ),
      ),
    );
  }
}
