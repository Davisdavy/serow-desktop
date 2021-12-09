class GoodsReturnNotes {
  GoodsReturnNotes({
      this.id, 
      this.goodsReturnNoteItems, 
      this.supplier, 
      this.branch, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.code, 
      this.tradeDiscountPercentage, 
      this.paymentDate, 
      this.discountAmount, 
      this.totalNet, 
      this.vatAmount, 
      this.totalAmount, 
      this.totalCost, 
      this.noOfItems, 
      this.notes, 
      this.status, 
      this.postedAt, 
      this.supplierInvoice, 
      this.company,});

  GoodsReturnNotes.fromJson(dynamic json) {
    id = json['id'];
    if (json['goods_return_note_items'] != null) {
      goodsReturnNoteItems = [];
      json['goods_return_note_items'].forEach((v) {
        goodsReturnNoteItems.add(Goods_return_note_items.fromJson(v));
      });
    }
    supplier = json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    tradeDiscountPercentage = json['trade_discount_percentage'];
    paymentDate = json['payment_date'];
    discountAmount = json['discount_amount'];
    totalNet = json['total_net'];
    vatAmount = json['vat_amount'];
    totalAmount = json['total_amount'];
    totalCost = json['total_cost'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    status = json['status'];
    postedAt = json['posted_at'];
    supplierInvoice = json['supplier_invoice'];
    company = json['company'];
  }
  String id;
  List<Goods_return_note_items> goodsReturnNoteItems;
  Supplier supplier;
  Branch branch;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double tradeDiscountPercentage;
  dynamic paymentDate;
  double discountAmount;
  double totalNet;
  double vatAmount;
  double totalAmount;
  double totalCost;
  int noOfItems;
  dynamic notes;
  String status;
  String postedAt;
  String supplierInvoice;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (goodsReturnNoteItems != null) {
      map['goods_return_note_items'] = goodsReturnNoteItems.map((v) => v.toJson()).toList();
    }
    if (supplier != null) {
      map['supplier'] = supplier.toJson();
    }
    if (branch != null) {
      map['branch'] = branch.toJson();
    }
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['code'] = code;
    map['trade_discount_percentage'] = tradeDiscountPercentage;
    map['payment_date'] = paymentDate;
    map['discount_amount'] = discountAmount;
    map['total_net'] = totalNet;
    map['vat_amount'] = vatAmount;
    map['total_amount'] = totalAmount;
    map['total_cost'] = totalCost;
    map['no_of_items'] = noOfItems;
    map['notes'] = notes;
    map['status'] = status;
    map['posted_at'] = postedAt;
    map['supplier_invoice'] = supplierInvoice;
    map['company'] = company;
    return map;
  }

}

class Branch {
  Branch({
      this.id, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.name, 
      this.description, 
      this.email, 
      this.location, 
      this.phone, 
      this.isHead, 
      this.region, 
      this.costCentre, 
      this.company,});

  Branch.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    description = json['description'];
    email = json['email'];
    location = json['location'];
    phone = json['phone'];
    isHead = json['is_head'];
    region = json['region'];
    costCentre = json['cost_centre'];
    company = json['company'];
  }
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String description;
  String email;
  String location;
  String phone;
  bool isHead;
  dynamic region;
  String costCentre;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['name'] = name;
    map['description'] = description;
    map['email'] = email;
    map['location'] = location;
    map['phone'] = phone;
    map['is_head'] = isHead;
    map['region'] = region;
    map['cost_centre'] = costCentre;
    map['company'] = company;
    return map;
  }

}

class Supplier {
  Supplier({
      this.id, 
      this.supplierContacts, 
      this.postingCategory, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.code, 
      this.name, 
      this.logo, 
      this.description, 
      this.email, 
      this.physicalAddress, 
      this.phoneCountryCode, 
      this.phone, 
      this.creditLimit, 
      this.lastPayDate, 
      this.lastPayAmount, 
      this.balance, 
      this.totalPurchases, 
      this.pinNo, 
      this.vatNo, 
      this.useLocalCurrency, 
      this.currency, 
      this.company,});

  Supplier.fromJson(dynamic json) {
    id = json['id'];
    if (json['supplier_contacts'] != null) {
      supplierContacts = [];
      json['supplier_contacts'].forEach((v) {
        supplierContacts.add(Supplier_contacts.fromJson(v));
      });
    }
    postingCategory = json['posting_category'] != null ? Posting_category.fromJson(json['postingCategory']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    email = json['email'];
    physicalAddress = json['physical_address'];
    phoneCountryCode = json['phone_country_code'];
    phone = json['phone'];
    creditLimit = json['credit_limit'];
    lastPayDate = json['last_pay_date'];
    lastPayAmount = json['last_pay_amount'];
    balance = json['balance'];
    totalPurchases = json['total_purchases'];
    pinNo = json['pin_no'];
    vatNo = json['vat_no'];
    useLocalCurrency = json['use_local_currency'];
    currency = json['currency'];
    company = json['company'];
  }
  String id;
  List<Supplier_contacts> supplierContacts;
  Posting_category postingCategory;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  dynamic logo;
  String description;
  String email;
  String physicalAddress;
  String phoneCountryCode;
  String phone;
  double creditLimit;
  dynamic lastPayDate;
  double lastPayAmount;
  double balance;
  double totalPurchases;
  String pinNo;
  String vatNo;
  bool useLocalCurrency;
  String currency;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (supplierContacts != null) {
      map['supplier_contacts'] = supplierContacts.map((v) => v.toJson()).toList();
    }
    if (postingCategory != null) {
      map['posting_category'] = postingCategory.toJson();
    }
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['code'] = code;
    map['name'] = name;
    map['logo'] = logo;
    map['description'] = description;
    map['email'] = email;
    map['physical_address'] = physicalAddress;
    map['phone_country_code'] = phoneCountryCode;
    map['phone'] = phone;
    map['credit_limit'] = creditLimit;
    map['last_pay_date'] = lastPayDate;
    map['last_pay_amount'] = lastPayAmount;
    map['balance'] = balance;
    map['total_purchases'] = totalPurchases;
    map['pin_no'] = pinNo;
    map['vat_no'] = vatNo;
    map['use_local_currency'] = useLocalCurrency;
    map['currency'] = currency;
    map['company'] = company;
    return map;
  }

}

class Posting_category {
  Posting_category({
      this.id, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.code, 
      this.name, 
      this.account, 
      this.company,});

  Posting_category.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    name = json['name'];
    account = json['account'];
    company = json['company'];
  }
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  String account;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['code'] = code;
    map['name'] = name;
    map['account'] = account;
    map['company'] = company;
    return map;
  }

}

class Supplier_contacts {
  Supplier_contacts({
      this.id, 
      this.supplier, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.name, 
      this.physicalAddress, 
      this.email, 
      this.phone, 
      this.company,});

  Supplier_contacts.fromJson(dynamic json) {
    id = json['id'];
    supplier = json['supplier'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    physicalAddress = json['physical_address'];
    email = json['email'];
    phone = json['phone'];
    company = json['company'];
  }
  String id;
  String supplier;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String physicalAddress;
  String email;
  String phone;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['supplier'] = supplier;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['name'] = name;
    map['physical_address'] = physicalAddress;
    map['email'] = email;
    map['phone'] = phone;
    map['company'] = company;
    return map;
  }

}

class Goods_return_note_items {
  Goods_return_note_items({
      this.id, 
      this.item, 
      this.createdAt, 
      this.modifiedAt, 
      this.isActive, 
      this.isDeleted, 
      this.deletedAt, 
      this.quantity, 
      this.unitCost, 
      this.bonus, 
      this.totalQuantity, 
      this.expiryDate, 
      this.batchNumber, 
      this.discountPercentage, 
      this.discountAmount, 
      this.netAmount, 
      this.vatPercentage, 
      this.vatAmount, 
      this.totalCost, 
      this.goodsReturnNote, 
      this.batch, 
      this.branch, 
      this.company,});

  Goods_return_note_items.fromJson(dynamic json) {
    id = json['id'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    bonus = json['bonus'];
    totalQuantity = json['total_quantity'];
    expiryDate = json['expiry_date'];
    batchNumber = json['batch_number'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    vatPercentage = json['vat_percentage'];
    vatAmount = json['vat_amount'];
    totalCost = json['total_cost'];
    goodsReturnNote = json['goods_return_note'];
    batch = json['batch'];
    branch = json['branch'];
    company = json['company'];
  }
  String id;
  Item item;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  double unitCost;
  double bonus;
  double totalQuantity;
  dynamic expiryDate;
  dynamic batchNumber;
  double discountPercentage;
  double discountAmount;
  double netAmount;
  double vatPercentage;
  double vatAmount;
  double totalCost;
  String goodsReturnNote;
  dynamic batch;
  String branch;
  String company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (item != null) {
      map['item'] = item.toJson();
    }
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['deleted_at'] = deletedAt;
    map['quantity'] = quantity;
    map['unit_cost'] = unitCost;
    map['bonus'] = bonus;
    map['total_quantity'] = totalQuantity;
    map['expiry_date'] = expiryDate;
    map['batch_number'] = batchNumber;
    map['discount_percentage'] = discountPercentage;
    map['discount_amount'] = discountAmount;
    map['net_amount'] = netAmount;
    map['vat_percentage'] = vatPercentage;
    map['vat_amount'] = vatAmount;
    map['total_cost'] = totalCost;
    map['goods_return_note'] = goodsReturnNote;
    map['batch'] = batch;
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