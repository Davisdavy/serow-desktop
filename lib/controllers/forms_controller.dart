

import 'package:flutter/material.dart';
import 'package:serow/models/inventory/forms.dart';
import 'package:serow/repository/forms_repository.dart';

class FormsController{
  final FormsRepository _repository;
  FormsController(this._repository);

  //get
  Future<List<Results> >fetchFormsList(BuildContext context){
    return _repository.getFormsList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results groups) async{
    return _repository.patchForms(groups);
  }

  //put
  Future<String >updatePutCompleted(Results groups) async{
    return _repository.putForms(groups);
  }

  //delete
  Future<String>deleteForms(String id, BuildContext context) async{
    return _repository.deletedForms(id, context);
  }

  //delete
  Future<Forms>postForms(String name, BuildContext context) async{
    return _repository.postForms(name, context);
  }
}