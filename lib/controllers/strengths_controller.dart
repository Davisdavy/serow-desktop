

import 'package:serow/models/inventory/strengths.dart';
import 'package:serow/respository/strengths_repository.dart';

class StrengthsController{
  final StrengthsRepository _repository;
  StrengthsController(this._repository);

  //get
  Future<List<Results> >fetchStrengthsList(){
    return _repository.getStrengthsList();
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchStrength(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putStrength(result);
  }

  //delete
  Future<void>deleteStrength(String id) async{
    return _repository.deletedStrength(id);
  }

  //delete
  Future<Strengths>postStrength(String name, String shortName) async{
    return _repository.postStrength(name,shortName);
  }
}