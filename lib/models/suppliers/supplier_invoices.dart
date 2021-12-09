class SupplierInvoices {
  String id;
  List<SupplierInvoiceItems> supplierInvoiceItems;
  Supplier supplier;
  Branch branch;
  PurchaseOrder purchaseOrder;
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
  double totalCost;
  double totalAmount;
  int noOfItems;
  dynamic notes;
  String receivedDate;
  String postedAt;
  double paidAmount;
  double balanceAmount;
  bool paymentCompleted;
  String status;
  String company;

  SupplierInvoices(
      {this.id,
        this.supplierInvoiceItems,
        this.supplier,
        this.branch,
        this.purchaseOrder,
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
        this.totalCost,
        this.totalAmount,
        this.noOfItems,
        this.notes,
        this.receivedDate,
        this.postedAt,
        this.paidAmount,
        this.balanceAmount,
        this.paymentCompleted,
        this.status,
        this.company});

  SupplierInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['supplier_invoice_items'] != null) {
      supplierInvoiceItems = new List<SupplierInvoiceItems>();
      json['supplier_invoice_items'].forEach((v) {
        supplierInvoiceItems.add(new SupplierInvoiceItems.fromJson(v));
      });
    }
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    branch =
    json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    purchaseOrder = json['purchase_order'] != null
        ? new PurchaseOrder.fromJson(json['purchase_order'])
        : null;
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
    totalCost = json['total_cost'];
    totalAmount = json['total_amount'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    receivedDate = json['received_date'];
    postedAt = json['posted_at'];
    paidAmount = json['paid_amount'];
    balanceAmount = json['balance_amount'];
    paymentCompleted = json['payment_completed'];
    status = json['status'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.supplierInvoiceItems != null) {
      data['supplier_invoice_items'] =
          this.supplierInvoiceItems.map((v) => v.toJson()).toList();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch.toJson();
    }
    if (this.purchaseOrder != null) {
      data['purchase_order'] = this.purchaseOrder.toJson();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['trade_discount_percentage'] = this.tradeDiscountPercentage;
    data['payment_date'] = this.paymentDate;
    data['discount_amount'] = this.discountAmount;
    data['total_net'] = this.totalNet;
    data['vat_amount'] = this.vatAmount;
    data['total_cost'] = this.totalCost;
    data['total_amount'] = this.totalAmount;
    data['no_of_items'] = this.noOfItems;
    data['notes'] = this.notes;
    data['received_date'] = this.receivedDate;
    data['posted_at'] = this.postedAt;
    data['paid_amount'] = this.paidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['payment_completed'] = this.paymentCompleted;
    data['status'] = this.status;
    data['company'] = this.company;
    return data;
  }
}

class SupplierInvoiceItems {
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
  double totalAmount;
  String supplierInvoice;
  String branch;
  String company;

  SupplierInvoiceItems(
      {this.id,
        this.item,
        this.batch,
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
        this.totalAmount,
        this.supplierInvoice,
        this.branch,
        this.company});

  SupplierInvoiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    batch = json['batch'];
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
    totalAmount = json['total_amount'];
    supplierInvoice = json['supplier_invoice'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['batch'] = this.batch;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['quantity'] = this.quantity;
    data['unit_cost'] = this.unitCost;
    data['bonus'] = this.bonus;
    data['total_quantity'] = this.totalQuantity;
    data['expiry_date'] = this.expiryDate;
    data['batch_number'] = this.batchNumber;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['net_amount'] = this.netAmount;
    data['vat_percentage'] = this.vatPercentage;
    data['vat_amount'] = this.vatAmount;
    data['total_cost'] = this.totalCost;
    data['total_amount'] = this.totalAmount;
    data['supplier_invoice'] = this.supplierInvoice;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class Item {
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

  Item(
      {this.id,
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
        this.company});

  Item.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['no'] = this.no;
    data['code'] = this.code;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['cost_price'] = this.costPrice;
    data['avg_cost_price'] = this.avgCostPrice;
    data['trade_price'] = this.tradePrice;
    data['retail_price'] = this.retailPrice;
    data['minimum_price'] = this.minimumPrice;
    data['maximum_price'] = this.maximumPrice;
    data['wholesale_price'] = this.wholesalePrice;
    data['minimum_wholesale_price'] = this.minimumWholesalePrice;
    data['maximum_wholesale_price'] = this.maximumWholesalePrice;
    data['supplier_price'] = this.supplierPrice;
    data['special_price'] = this.specialPrice;
    data['vat_percentage'] = this.vatPercentage;
    data['use_pricing_formula'] = this.usePricingFormula;
    data['image'] = this.image;
    data['barcode'] = this.barcode;
    data['packsize'] = this.packsize;
    data['description'] = this.description;
    data['availability'] = this.availability;
    data['balance'] = this.balance;
    data['usage'] = this.usage;
    data['warnings'] = this.warnings;
    data['prescription'] = this.prescription;
    data['priority'] = this.priority;
    data['selling_options'] = this.sellingOptions;
    data['total_revenue'] = this.totalRevenue;
    data['total_purchases'] = this.totalPurchases;
    data['pricing'] = this.pricing;
    data['brand'] = this.brand;
    data['item_form'] = this.itemForm;
    data['strength'] = this.strength;
    data['group'] = this.group;
    data['subgroup'] = this.subgroup;
    data['category'] = this.category;
    data['company'] = this.company;
    return data;
  }
}

class Supplier {
  String id;
  List<SupplierContacts> supplierContacts;
  PostingCategory postingCategory;
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

  Supplier(
      {this.id,
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
        this.company});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['supplier_contacts'] != null) {
      supplierContacts = new List<SupplierContacts>();
      json['supplier_contacts'].forEach((v) {
        supplierContacts.add(new SupplierContacts.fromJson(v));
      });
    }
    postingCategory = json['posting_category'] != null
        ? new PostingCategory.fromJson(json['posting_category'])
        : null;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.supplierContacts != null) {
      data['supplier_contacts'] =
          this.supplierContacts.map((v) => v.toJson()).toList();
    }
    if (this.postingCategory != null) {
      data['posting_category'] = this.postingCategory.toJson();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['email'] = this.email;
    data['physical_address'] = this.physicalAddress;
    data['phone_country_code'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['credit_limit'] = this.creditLimit;
    data['last_pay_date'] = this.lastPayDate;
    data['last_pay_amount'] = this.lastPayAmount;
    data['balance'] = this.balance;
    data['total_purchases'] = this.totalPurchases;
    data['pin_no'] = this.pinNo;
    data['vat_no'] = this.vatNo;
    data['use_local_currency'] = this.useLocalCurrency;
    data['currency'] = this.currency;
    data['company'] = this.company;
    return data;
  }
}

class SupplierContacts {
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

  SupplierContacts(
      {this.id,
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
        this.company});

  SupplierContacts.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier'] = this.supplier;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['physical_address'] = this.physicalAddress;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company'] = this.company;
    return data;
  }
}

class PostingCategory {
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

  PostingCategory(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.name,
        this.account,
        this.company});

  PostingCategory.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['name'] = this.name;
    data['account'] = this.account;
    data['company'] = this.company;
    return data;
  }
}

class Branch {
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

  Branch(
      {this.id,
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
        this.company});

  Branch.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['email'] = this.email;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['is_head'] = this.isHead;
    data['region'] = this.region;
    data['cost_centre'] = this.costCentre;
    data['company'] = this.company;
    return data;
  }
}

class PurchaseOrder {
  String id;
  List<PurchaseOrderItems> purchaseOrderItems;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double tradeDiscountPercentage;
  double discountAmount;
  double totalNet;
  double vatAmount;
  double totalCost;
  double totalAmount;
  int noOfItems;
  dynamic notes;
  String purchaseStatus;
  String supplier;
  String branch;
  String company;

  PurchaseOrder(
      {this.id,
        this.purchaseOrderItems,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.tradeDiscountPercentage,
        this.discountAmount,
        this.totalNet,
        this.vatAmount,
        this.totalCost,
        this.totalAmount,
        this.noOfItems,
        this.notes,
        this.purchaseStatus,
        this.supplier,
        this.branch,
        this.company});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['purchase_order_items'] != null) {
      purchaseOrderItems = new List<PurchaseOrderItems>();
      json['purchase_order_items'].forEach((v) {
        purchaseOrderItems.add(new PurchaseOrderItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    tradeDiscountPercentage = json['trade_discount_percentage'];
    discountAmount = json['discount_amount'];
    totalNet = json['total_net'];
    vatAmount = json['vat_amount'];
    totalCost = json['total_cost'];
    totalAmount = json['total_amount'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    purchaseStatus = json['purchase_status'];
    supplier = json['supplier'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.purchaseOrderItems != null) {
      data['purchase_order_items'] =
          this.purchaseOrderItems.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['trade_discount_percentage'] = this.tradeDiscountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['total_net'] = this.totalNet;
    data['vat_amount'] = this.vatAmount;
    data['total_cost'] = this.totalCost;
    data['total_amount'] = this.totalAmount;
    data['no_of_items'] = this.noOfItems;
    data['notes'] = this.notes;
    data['purchase_status'] = this.purchaseStatus;
    data['supplier'] = this.supplier;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class PurchaseOrderItems {
  String id;
  String purchaseOrder;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  double unitCost;
  double bonus;
  double totalQuantity;
  double discountPercentage;
  double discountAmount;
  double netAmount;
  double vatPercentage;
  double vatAmount;
  double totalCost;
  double totalAmount;
  String item;
  dynamic branch;
  String company;

  PurchaseOrderItems(
      {this.id,
        this.purchaseOrder,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.quantity,
        this.unitCost,
        this.bonus,
        this.totalQuantity,
        this.discountPercentage,
        this.discountAmount,
        this.netAmount,
        this.vatPercentage,
        this.vatAmount,
        this.totalCost,
        this.totalAmount,
        this.item,
        this.branch,
        this.company});

  PurchaseOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseOrder = json['purchase_order'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    bonus = json['bonus'];
    totalQuantity = json['total_quantity'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    vatPercentage = json['vat_percentage'];
    vatAmount = json['vat_amount'];
    totalCost = json['total_cost'];
    totalAmount = json['total_amount'];
    item = json['item'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_order'] = this.purchaseOrder;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['quantity'] = this.quantity;
    data['unit_cost'] = this.unitCost;
    data['bonus'] = this.bonus;
    data['total_quantity'] = this.totalQuantity;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['net_amount'] = this.netAmount;
    data['vat_percentage'] = this.vatPercentage;
    data['vat_amount'] = this.vatAmount;
    data['total_cost'] = this.totalCost;
    data['total_amount'] = this.totalAmount;
    data['item'] = this.item;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}