import 'package:flutter/material.dart';

class User{
  final  String id;
  final  String email_address;

  User({
    required this.id, 
    required this.email_address, 

});

Map<String , dynamic > toJson() => {

    'id' : id,
    'email' : email_address
  };
}