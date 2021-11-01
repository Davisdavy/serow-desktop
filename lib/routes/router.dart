import 'package:flutter/material.dart';
import 'package:serow/pages/accounts/accounts.dart';
import 'package:serow/pages/accounts/cost_centers/cost_centers.dart';
import 'package:serow/pages/entities/branches/branches.dart';
import 'package:serow/pages/entities/clients/clients.dart';
import 'package:serow/pages/entities/company/company.dart';
import 'package:serow/pages/entities/regions/regions.dart';
import 'package:serow/pages/entities/servers/servers.dart';
import 'package:serow/pages/faqs/faqs.dart';

import 'package:serow/pages/helpsupport/help_support.dart';
import 'package:serow/pages/inventory/brands/brands.dart';
import 'package:serow/pages/inventory/categories/categories.dart';
import 'package:serow/pages/inventory/forms/forms.dart';
import 'package:serow/pages/inventory/groups/groups.dart';
import 'package:serow/pages/inventory/items/items.dart';
import 'package:serow/pages/inventory/locations/locations.dart';
import 'package:serow/pages/inventory/pricing/pricing.dart';
import 'package:serow/pages/inventory/shelves/shelves.dart';
import 'package:serow/pages/inventory/stock_requisition/stock_requisition.dart';
import 'package:serow/pages/inventory/strengths/strengths.dart';
import 'package:serow/pages/inventory/subgroups/subgroups.dart';
import 'package:serow/pages/notifications/notifications.dart';
import 'package:serow/pages/orders/orders.dart';
import 'package:serow/pages/overview/overview.dart';
import 'package:serow/pages/predictions/predictions.dart';
import 'package:serow/pages/products/products.dart';
import 'package:serow/pages/reports/reports.dart';
import 'package:serow/pages/sales/customers/customers.dart';
import 'package:serow/pages/settings/settings.dart';
import 'package:serow/pages/suppliers/goods_received_note/goods_received_note.dart';
import 'package:serow/pages/suppliers/goods_return_note/goods_return_note.dart';
import 'package:serow/pages/suppliers/posting_categories/posting_categories.dart';
import 'package:serow/pages/suppliers/purchase_orders/purchase_orders.dart';
import 'package:serow/pages/suppliers/supplier_invoices/supplier_invoices.dart';
import 'package:serow/pages/suppliers/suppliers.dart';

import 'package:serow/pages/teams/teams.dart';
import 'package:serow/routes/routes.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case OverviewPageRoute:
      return _getPageRoute(OverviewPage());
    case NotificationsPageRoute:
      return _getPageRoute(NotificationsPage());
    case BrandsPageRoute:
      return _getPageRoute(BrandsPage());
    case CategoriesPageRoute:
      return _getPageRoute(CategoriesPage());
    case FormsPageRoute:
      return _getPageRoute(FormsPage());
    case GroupsPageRoute:
      return _getPageRoute(GroupsPage());
    case ItemsPageRoute:
      return _getPageRoute(ItemsPage());
    case LocationsPageRoute:
      return _getPageRoute(LocationsPage());
    case PricingPageRoute:
      return _getPageRoute(PricingPage());
    case ShelvesPageRoute:
      return _getPageRoute(ShelvesPage());
    case StockRequisitionPageRoute:
      return _getPageRoute(StockRequisitionPage());
    case StrengthsPageRoute:
      return _getPageRoute(StrengthsPage());
    case SubgroupsPageRoute:
      return _getPageRoute(SubgroupsPage());
    case BranchesPageRoute:
      return _getPageRoute(BranchesPage());
    case ClientsPageRoute:
      return _getPageRoute(ClientsPage());
    case CompanyPageRoute:
      return _getPageRoute(CompanyPage());
    case RegionsPageRoute:
      return _getPageRoute(RegionsPage());
    case ServersPageRoute:
      return _getPageRoute(ServersPage());
    case ProductsPageRoute:
      return _getPageRoute(ProductsPage());
    case CustomersPageRoute:
      return _getPageRoute(CustomersPage());
    case SuppliersPageRoute:
      return _getPageRoute(SuppliersPage());
    case PredictionsPageRoute:
      return _getPageRoute(PredictionsPage());
    case SuppliersInvoicesPageRoute:
      return _getPageRoute(SupplierInvoicesPage());
    case PurchaseOrdersPageRoute:
      return _getPageRoute(PurchaseOrdersPage());
    case PostingCategoriesPageRoute:
      return _getPageRoute(PostingCategoriesPage());
    case GoodsReturnNotePageRoute:
      return _getPageRoute(GoodsReturnNotePage());
    case GoodsReceivedNotePageRoute:
      return _getPageRoute(GoodsReceivedNotePage());
    case FAQPageRoute:
      return _getPageRoute(FAQsPage());
    case TeamPageRoute:
      return _getPageRoute(TeamsPage());
    case HelpSupportPageRoute:
      return _getPageRoute(HelpSupportPage());
    case SettingPageRoute:
      return _getPageRoute(SettingsPage());
    case ReportsPageRoute:
      return _getPageRoute(ReportsPage());
    case AccountsPageRoute:
      return _getPageRoute(AccountsPage());
    case CostCentersPageRoute:
      return _getPageRoute(CostCentersPage());
    case OrdersPageRoute:
      return _getPageRoute(OrdersPage());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}