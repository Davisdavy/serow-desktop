

import 'package:serow/models/inventory/forms.dart';
import 'package:serow/respository/forms_repository.dart';

class FormsController{
  final FormsRepository _repository;
  FormsController(this._repository);

  //get
  Future<List<Results> >fetchFormsList(){
    return _repository.getFormsList();
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
  Future<void>deleteForms(String id) async{
    return _repository.deletedForms(id);
  }

  //delete
  Future<Forms>postForms(String name) async{
    return _repository.postForms(name);
  }
}