class Sales {
  Sales({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  Sales.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }
  int count;
  String next;
  dynamic previous;
  List<Results> results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      this.id, 
      this.saleItems, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.code, 
      this.discountPercentage, 
      this.discountAmount, 
      this.totalNet, 
      this.vatAmount, 
      this.totalAmount, 
      this.totalCost, 
      this.totalProfit, 
      this.commissionAmount, 
      this.noOfItems, 
      this.notes, 
      this.status, 
      this.postedAt, 
      this.customer, 
      this.quotation, 
      this.salesPerson, 
      this.branch, 
      this.company,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    if (json['sale_items'] != null) {
      saleItems = [];
      json['sale_items'].forEach((v) {
        saleItems.add(Sale_items.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    totalNet = json['total_net'];
    vatAmount = json['vat_amount'];
    totalAmount = json['total_amount'];
    totalCost = json['total_cost'];
    totalProfit = json['total_profit'];
    commissionAmount = json['commission_amount'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    status = json['status'];
    postedAt = json['posted_at'];
    customer = json['customer'];
    quotation = json['quotation'];
    salesPerson = json['sales_person'];
    branch = json['branch'];
    company = json['company'];
  }
  String id;
  List<Sale_items> saleItems;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double discountPercentage;
  double discountAmount;
  double totalNet;
  double vatAmount;
  double totalAmount;
  double totalCost;
  double totalProfit;
  double commissionAmount;
  int noOfItems;
  dynamic notes;
  String status;
  dynamic postedAt;
  String customer;
  dynamic quotation;
  dynamic salesPerson;
  String branch;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (saleItems != null) {
      map['sale_items'] = saleItems.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['code'] = code;
    map['discount_percentage'] = discountPercentage;
    map['discount_amount'] = discountAmount;
    map['total_net'] = totalNet;
    map['vat_amount'] = vatAmount;
    map['total_amount'] = totalAmount;
    map['total_cost'] = totalCost;
    map['total_profit'] = totalProfit;
    map['commission_amount'] = commissionAmount;
    map['no_of_items'] = noOfItems;
    map['notes'] = notes;
    map['status'] = status;
    map['posted_at'] = postedAt;
    map['customer'] = customer;
    map['quotation'] = quotation;
    map['sales_person'] = salesPerson;
    map['branch'] = branch;
    map['company'] = company;
    return map;
  }

}

class Sale_items {
  Sale_items({
      this.id, 
      this.item, 
      this.batch, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.quantity, 
      this.unitCost, 
      this.unitPrice, 
      this.bonus, 
      this.totalQuantity, 
      this.discountPercentage, 
      this.discountAmount, 
      this.netAmount, 
      this.vatPercentage, 
      this.vatAmount, 
      this.totalCost, 
      this.totalAmount, 
      this.totalProfit, 
      this.sale, 
      this.branch, 
      this.company,});

  Sale_items.fromJson(dynamic json) {
    id = json['id'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    batch = json['batch'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    unitPrice = json['unit_price'];
    bonus = json['bonus'];
    totalQuantity = json['total_quantity'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    vatPercentage = json['vat_percentage'];
    vatAmount = json['vat_amount'];
    totalCost = json['total_cost'];
    totalAmount = json['total_amount'];
    totalProfit = json['total_profit'];
    sale = json['sale'];
    branch = json['branch'];
    company = json['company'];
  }
  String id;
  Item item;
  dynamic batch;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  double unitCost;
  double unitPrice;
  double bonus;
  double totalQuantity;
  double discountPercentage;
  double discountAmount;
  double netAmount;
  double vatPercentage;
  double vatAmount;
  double totalCost;
  double totalAmount;
  double totalProfit;
  String sale;
  String branch;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (item != null) {
      map['item'] = item.toJson();
    }
    map['batch'] = batch;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['quantity'] = quantity;
    map['unit_cost'] = unitCost;
    map['unit_price'] = unitPrice;
    map['bonus'] = bonus;
    map['total_quantity'] = totalQuantity;
    map['discount_percentage'] = discountPercentage;
    map['discount_amount'] = discountAmount;
    map['net_amount'] = netAmount;
    map['vat_percentage'] = vatPercentage;
    map['vat_amount'] = vatAmount;
    map['total_cost'] = totalCost;
    map['total_amount'] = totalAmount;
    map['total_profit'] = totalProfit;
    map['sale'] = sale;
    map['branch'] = branch;
    map['company'] = company;
    return map;
  }

}

class Item {
  Item({
      this.id, 
      this.imageUrl, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.no, 
      this.code, 
      this.name, 
      this.slug, 
      this.costPrice, 
      this.avgCostPrice, 
      this.tradePrice, 
      this.retailPrice, 
      this.minimumPrice, 
      this.maximumPrice, 
      this.wholesalePrice, 
      this.minimumWholesalePrice, 
      this.maximumWholesalePrice, 
      this.supplierPrice, 
      this.specialPrice, 
      this.vatPercentage, 
      this.usePricingFormula, 
      this.image, 
      this.barcode, 
      this.packsize, 
      this.description, 
      this.availability, 
      this.balance, 
      this.usage, 
      this.warnings, 
      this.prescription, 
      this.priority, 
      this.sellingOptions, 
      this.totalRevenue, 
      this.totalPurchases, 
      this.pricing, 
      this.brand, 
      this.itemForm, 
      this.strength, 
      this.group, 
      this.subgroup, 
      this.category, 
      this.company,});

  Item.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    no = json['no'];
    code = json['code'];
    name = json['name'];
    slug = json['slug'];
    costPrice = json['cost_price'];
    avgCostPrice = json['avg_cost_price'];
    tradePrice = json['trade_price'];
    retailPrice = json['retail_price'];
    minimumPrice = json['minimum_price'];
    maximumPrice = json['maximum_price'];
    wholesalePrice = json['wholesale_price'];
    minimumWholesalePrice = json['minimum_wholesale_price'];
    maximumWholesalePrice = json['maximum_wholesale_price'];
    supplierPrice = json['supplier_price'];
    specialPrice = json['special_price'];
    vatPercentage = json['vat_percentage'];
    usePricingFormula = json['use_pricing_formula'];
    image = json['image'];
    barcode = json['barcode'];
    packsize = json['packsize'];
    description = json['description'];
    availability = json['availability'];
    balance = json['balance'];
    usage = json['usage'];
    warnings = json['warnings'];
    prescription = json['prescription'];
    priority = json['priority'];
    sellingOptions = json['selling_options'];
    totalRevenue = json['total_revenue'];
    totalPurchases = json['total_purchases'];
    pricing = json['pricing'];
    brand = json['brand'];
    itemForm = json['item_form'];
    strength = json['strength'];
    group = json['group'];
    subgroup = json['subgroup'];
    category = json['category'];
    company = json['company'];
  }
  String id;
  String imageUrl;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  int no;
  String code;
  String name;
  String slug;
  double costPrice;
  double avgCostPrice;
  double tradePrice;
  double retailPrice;
  double minimumPrice;
  double maximumPrice;
  double wholesalePrice;
  double minimumWholesalePrice;
  double maximumWholesalePrice;
  double supplierPrice;
  double specialPrice;
  double vatPercentage;
  bool usePricingFormula;
  String image;
  dynamic barcode;
  int packsize;
  String description;
  String availability;
  double balance;
  String usage;
  dynamic warnings;
  bool prescription;
  int priority;
  String sellingOptions;
  double totalRevenue;
  double totalPurchases;
  dynamic pricing;
  String brand;
  String itemForm;
  String strength;
  String group;
  String subgroup;
  String category;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image_url'] = imageUrl;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['no'] = no;
    map['code'] = code;
    map['name'] = name;
    map['slug'] = slug;
    map['cost_price'] = costPrice;
    map['avg_cost_price'] = avgCostPrice;
    map['trade_price'] = tradePrice;
    map['retail_price'] = retailPrice;
    map['minimum_price'] = minimumPrice;
    map['maximum_price'] = maximumPrice;
    map['wholesale_price'] = wholesalePrice;
    map['minimum_wholesale_price'] = minimumWholesalePrice;
    map['maximum_wholesale_price'] = maximumWholesalePrice;
    map['supplier_price'] = supplierPrice;
    map['special_price'] = specialPrice;
    map['vat_percentage'] = vatPercentage;
    map['use_pricing_formula'] = usePricingFormula;
    map['image'] = image;
    map['barcode'] = barcode;
    map['packsize'] = packsize;
    map['description'] = description;
    map['availability'] = availability;
    map['balance'] = balance;
    map['usage'] = usage;
    map['warnings'] = warnings;
    map['prescription'] = prescription;
    map['priority'] = priority;
    map['selling_options'] = sellingOptions;
    map['total_revenue'] = totalRevenue;
    map['total_purchases'] = totalPurchases;
    map['pricing'] = pricing;
    map['brand'] = brand;
    map['item_form'] = itemForm;
    map['strength'] = strength;
    map['group'] = group;
    map['subgroup'] = subgroup;
    map['category'] = category;
    map['company'] = company;
    return map;
  }

}