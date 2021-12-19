import 'package:flutter/material.dart';

double getHeight(Orientation orientation, BuildContext context ){
  if(orientation == Orientation.portrait){
    return MediaQuery.of(context).size.height * 0.40;
  }else {
    return MediaQuery.of(context).size.height * 0.5;
  }
}


double getWidth(Orientation orientation ,BuildContext context ){
  if(orientation == Orientation.portrait){
    return MediaQuery.of(context).size.width * 0.55;
  }else {
    return MediaQuery.of(context).size.width * 0.50;
  }
}

int getCrossCount(Orientation orientation ,BuildContext context ){

  if(orientation == Orientation.portrait){
    return 2;
  }else {
    return 3;
  }


}

