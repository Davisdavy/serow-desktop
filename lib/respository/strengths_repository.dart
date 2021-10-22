


import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/strengths.dart';

abstract class StrengthsRepository {
  //Brands
  Future<List<Results>> getStrengthsList(BuildContext context);
  Future<String> patchStrength(Results result);
  Future<String> putStrength(Results result);
  Future<Results> deletedStrength(String id, BuildContext context);
  Future<Strengths> postStrength(String name, String shortName, BuildContext context);


}