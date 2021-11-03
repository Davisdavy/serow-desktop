// class Items {
//   int count;
//   Null next;
//   Null previous;
//   List<Results> results;
//
//   Items({this.count, this.next, this.previous, this.results});
//
//   Items.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     next = json['next'];
//     previous = json['previous'];
//     if (json['results'] != null) {
//       results = new List<Results>();
//       json['results'].forEach((v) {
//         results.add(new Results.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['next'] = this.next;
//     data['previous'] = this.previous;
//     if (this.results != null) {
//       data['results'] = this.results.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Results {
//   String id;
//   List<Null> group;
//   List<Null> subgroup;
//   List<Null> category;
//   String createdAt;
//   String modifiedAt;
//   bool isActive;
//   bool isDeleted;
//   Null deletedAt;
//   int no;
//   String code;
//   String name;
//   String slug;
//   int costPrice;
//   int avgCostPrice;
//   int tradePrice;
//   int retailPrice;
//   int minimumPrice;
//   int maximumPrice;
//   int wholesalePrice;
//   int minimumWholesalePrice;
//   int maximumWholesalePrice;
//   int supplierPrice;
//   int specialPrice;
//   int vatPercentage;
//   bool usePricingFormula;
//   String image;
//   Null barcode;
//   int packsize;
//   Null description;
//   String availability;
//   int balance;
//   Null usage;
//   Null warnings;
//   bool prescription;
//   int priority;
//   String sellingOptions;
//   int totalRevenue;
//   int totalPurchases;
//   Null pricing;
//   Null brand;
//   Null itemForm;
//   Null strength;
//   String company;
//
//   Results(
//       {this.id,
//         this.group,
//         this.subgroup,
//         this.category,
//         this.createdAt,
//         this.modifiedAt,
//         this.isActive,
//         this.isDeleted,
//         this.deletedAt,
//         this.no,
//         this.code,
//         this.name,
//         this.slug,
//         this.costPrice,
//         this.avgCostPrice,
//         this.tradePrice,
//         this.retailPrice,
//         this.minimumPrice,
//         this.maximumPrice,
//         this.wholesalePrice,
//         this.minimumWholesalePrice,
//         this.maximumWholesalePrice,
//         this.supplierPrice,
//         this.specialPrice,
//         this.vatPercentage,
//         this.usePricingFormula,
//         this.image,
//         this.barcode,
//         this.packsize,
//         this.description,
//         this.availability,
//         this.balance,
//         this.usage,
//         this.warnings,
//         this.prescription,
//         this.priority,
//         this.sellingOptions,
//         this.totalRevenue,
//         this.totalPurchases,
//         this.pricing,
//         this.brand,
//         this.itemForm,
//         this.strength,
//         this.company});
//
//   Results.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['group'] != null) {
//       group = new List<Null>();
//       json['group'].forEach((v) {
//         group.add(new Null.fromJson(v));
//       });
//     }
//     if (json['subgroup'] != null) {
//       subgroup = new List<Null>();
//       json['subgroup'].forEach((v) {
//         subgroup.add(new Null.fromJson(v));
//       });
//     }
//     if (json['category'] != null) {
//       category = new List<Null>();
//       json['category'].forEach((v) {
//         category.add(new Null.fromJson(v));
//       });
//     }
//     createdAt = json['created_at'];
//     modifiedAt = json['modified_at'];
//     isActive = json['is_active'];
//     isDeleted = json['is_deleted'];
//     deletedAt = json['deleted_at'];
//     no = json['no'];
//     code = json['code'];
//     name = json['name'];
//     slug = json['slug'];
//     costPrice = json['cost_price'];
//     avgCostPrice = json['avg_cost_price'];
//     tradePrice = json['trade_price'];
//     retailPrice = json['retail_price'];
//     minimumPrice = json['minimum_price'];
//     maximumPrice = json['maximum_price'];
//     wholesalePrice = json['wholesale_price'];
//     minimumWholesalePrice = json['minimum_wholesale_price'];
//     maximumWholesalePrice = json['maximum_wholesale_price'];
//     supplierPrice = json['supplier_price'];
//     specialPrice = json['special_price'];
//     vatPercentage = json['vat_percentage'];
//     usePricingFormula = json['use_pricing_formula'];
//     image = json['image'];
//     barcode = json['barcode'];
//     packsize = json['packsize'];
//     description = json['description'];
//     availability = json['availability'];
//     balance = json['balance'];
//     usage = json['usage'];
//     warnings = json['warnings'];
//     prescription = json['prescription'];
//     priority = json['priority'];
//     sellingOptions = json['selling_options'];
//     totalRevenue = json['total_revenue'];
//     totalPurchases = json['total_purchases'];
//     pricing = json['pricing'];
//     brand = json['brand'];
//     itemForm = json['item_form'];
//     strength = json['strength'];
//     company = json['company'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.group != null) {
//       data['group'] = this.group.map((v) => v.toJson()).toList();
//     }
//     if (this.subgroup != null) {
//       data['subgroup'] = this.subgroup.map((v) => v.toJson()).toList();
//     }
//     if (this.category != null) {
//       data['category'] = this.category.map((v) => v.toJson()).toList();
//     }
//     data['created_at'] = this.createdAt;
//     data['modified_at'] = this.modifiedAt;
//     data['is_active'] = this.isActive;
//     data['is_deleted'] = this.isDeleted;
//     data['deleted_at'] = this.deletedAt;
//     data['no'] = this.no;
//     data['code'] = this.code;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['cost_price'] = this.costPrice;
//     data['avg_cost_price'] = this.avgCostPrice;
//     data['trade_price'] = this.tradePrice;
//     data['retail_price'] = this.retailPrice;
//     data['minimum_price'] = this.minimumPrice;
//     data['maximum_price'] = this.maximumPrice;
//     data['wholesale_price'] = this.wholesalePrice;
//     data['minimum_wholesale_price'] = this.minimumWholesalePrice;
//     data['maximum_wholesale_price'] = this.maximumWholesalePrice;
//     data['supplier_price'] = this.supplierPrice;
//     data['special_price'] = this.specialPrice;
//     data['vat_percentage'] = this.vatPercentage;
//     data['use_pricing_formula'] = this.usePricingFormula;
//     data['image'] = this.image;
//     data['barcode'] = this.barcode;
//     data['packsize'] = this.packsize;
//     data['description'] = this.description;
//     data['availability'] = this.availability;
//     data['balance'] = this.balance;
//     data['usage'] = this.usage;
//     data['warnings'] = this.warnings;
//     data['prescription'] = this.prescription;
//     data['priority'] = this.priority;
//     data['selling_options'] = this.sellingOptions;
//     data['total_revenue'] = this.totalRevenue;
//     data['total_purchases'] = this.totalPurchases;
//     data['pricing'] = this.pricing;
//     data['brand'] = this.brand;
//     data['item_form'] = this.itemForm;
//     data['strength'] = this.strength;
//     data['company'] = this.company;
//     return data;
//   }
// }