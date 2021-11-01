
import 'package:flutter/material.dart';
import 'package:serow/models/accounts/accounts.dart';

abstract class AccountsRepository {
  //Brands
  Future<List<Results>> getAccountsList(BuildContext context);
  Future<String> patchAccounts(Results result);
  Future<String> putAccount(Results result);
  Future<Results> deletedAccount(String id, BuildContext context);
  Future<Accounts> postAccount(String name, String code, String group, String costCenter, BuildContext context);


}