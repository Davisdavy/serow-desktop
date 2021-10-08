import 'package:flutter/material.dart';
import 'package:serow/pages/accounts/accounts.dart';
import 'package:serow/pages/customers/customers.dart';
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
import 'package:serow/pages/inventory/strengths/strengths.dart';
import 'package:serow/pages/inventory/subgroups/subgroups.dart';
import 'package:serow/pages/notifications/notifications.dart';
import 'package:serow/pages/orders/orders.dart';
import 'package:serow/pages/overview/overview.dart';
import 'package:serow/pages/predictions/predictions.dart';
import 'package:serow/pages/products/products.dart';
import 'package:serow/pages/reports/reports.dart';
import 'package:serow/pages/settings/settings.dart';

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
    case StrengthsPageRoute:
      return _getPageRoute(StrengthsPage());
    case SubgroupsPageRoute:
      return _getPageRoute(SubGroupsPage());
    case ProductsPageRoute:
      return _getPageRoute(ProductsPage());
    case CustomersPageRoute:
      return _getPageRoute(CustomersPage());
    case SuppliersPageRoute:
      return _getPageRoute(SuppliersPage());
    case PredictionsPageRoute:
      return _getPageRoute(PredictionsPage());
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
    case OrdersPageRoute:
      return _getPageRoute(OrdersPage());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}