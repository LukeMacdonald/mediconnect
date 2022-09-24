import 'package:flutter/cupertino.dart';

Widget padding(double left, double top, double right, double bottom){
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(left, top, right, left),
  );
}