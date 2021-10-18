


import 'package:serow/models/inventory/strengths.dart';

abstract class StrengthsRepository {
  //Brands
  Future<List<Results>> getStrengthsList();
  Future<String> patchStrength(Results result);
  Future<String> putStrength(Results result);
  Future<Results> deletedStrength(String id);
  Future<Strengths> postStrength(String name, String shortName);


}