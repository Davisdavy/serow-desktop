

import 'package:flutter/material.dart';
import 'package:serow/models/accounts/accounts.dart';
import 'package:serow/respository/accounts_repository.dart';


class AccountsController{
  final AccountsRepository _repository;
  AccountsController(this._repository);

  //get
  Future<List<Results> >fetchAccountList(BuildContext context){
    return _repository.getAccountsList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchAccounts(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putAccount(result);
  }

  //delete
  Future<String>deleteAccount(String id, BuildContext context) async{
    return _repository.deletedAccount(id, context);
  }

  //delete
  Future<Accounts>postAccount(String name, String code, String group,String costCenter, BuildContext context) async{
    return _repository.postAccount(name,code,group, costCenter,context);
  }
}