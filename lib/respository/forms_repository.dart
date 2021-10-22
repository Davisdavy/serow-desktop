

import 'package:flutter/material.dart';
import 'package:serow/models/inventory/forms.dart';

abstract class FormsRepository {
  //Brands
  Future<List<Results>> getFormsList(BuildContext context);
  Future<String> patchForms(Results result);
  Future<String> putForms(Results result);
  Future<Results> deletedForms(String id, BuildContext context);
  Future<Forms> postForms(String name, BuildContext context);


}