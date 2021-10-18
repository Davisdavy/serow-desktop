

import 'package:serow/models/inventory/forms.dart';

abstract class FormsRepository {
  //Brands
  Future<List<Results>> getFormsList();
  Future<String> patchForms(Results result);
  Future<String> putForms(Results result);
  Future<Results> deletedForms(String id);
  Future<Forms> postForms(String name);


}