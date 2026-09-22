import 'package:get/get.dart';
import '../../widgets/placeholder_screen.dart';
import '../../views/splash/splash_screen.dart';
import '../../views/onboarding/onboarding_screen.dart';
import '../../views/auth/login_screen.dart';
import '../../views/auth/register_screen.dart';
import '../../views/auth/role_selection_screen.dart';
import '../../views/buyer/buyer_home_screen.dart';
import '../../views/buyer/product_list_screen.dart';
import '../../views/buyer/product_details_screen.dart';
import '../../views/buyer/wishlist_screen.dart';
import '../../views/buyer/cart_screen.dart';
import '../../views/buyer/ai_assistant_screen.dart';
import '../../views/buyer/quotation_request_screen.dart';
import '../../views/buyer/quotation_list_screen.dart';
import '../../views/buyer/quotation_details_screen.dart';
import '../../views/buyer/negotiation_screen.dart';
import '../../views/buyer/sample_request_screen.dart';
import '../../views/buyer/sample_list_screen.dart';
import '../../views/buyer/sample_details_screen.dart';
import '../../views/seller/seller_home_screen.dart';
import '../../views/seller/seller_add_product_screen.dart';
import '../../views/seller/seller_inventory_screen.dart';
import '../../views/seller/seller_quotations_screen.dart';
import '../../views/seller/seller_samples_screen.dart';
import '../../views/seller/seller_analytics_screen.dart';
import '../../views/seller/seller_order_details_screen.dart';
import '../../views/seller/seller_chat_screen.dart';
import '../../views/seller/seller_negotiation_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.roleSelection, page: () => const RoleSelectionScreen()),
    
    // Buyer Routes
    GetPage(name: AppRoutes.buyerHome, page: () => const BuyerHomeScreen()),
    GetPage(name: AppRoutes.categories, page: () => const PlaceholderScreen(title: 'Categories')),
    GetPage(name: AppRoutes.productList, page: () => const ProductListScreen()),
    GetPage(name: AppRoutes.productDetails, page: () => const ProductDetailsScreen()),
    GetPage(name: AppRoutes.wishlist, page: () => const WishlistScreen()),
    GetPage(name: AppRoutes.cart, page: () => const CartScreen()),
    GetPage(name: AppRoutes.checkout, page: () => const PlaceholderScreen(title: 'Checkout')),
    GetPage(name: AppRoutes.orders, page: () => const PlaceholderScreen(title: 'Orders')),
    GetPage(name: AppRoutes.orderDetails, page: () => const PlaceholderScreen(title: 'Order Details')),
    
    // AI Assistant
    GetPage(name: AppRoutes.aiAssistant, page: () => const AiAssistantScreen()),
    
    // Quotations & Samples
    GetPage(name: AppRoutes.quotationRequest, page: () => const QuotationRequestScreen()),
    GetPage(name: AppRoutes.quotationList, page: () => const QuotationListScreen()),
    GetPage(name: AppRoutes.quotationDetails, page: () => const QuotationDetailsScreen()),
    GetPage(name: AppRoutes.negotiation, page: () => const NegotiationScreen()),
    GetPage(name: AppRoutes.sampleRequest, page: () => const SampleRequestScreen()),
    GetPage(name: AppRoutes.sampleList, page: () => const SampleListScreen()),
    GetPage(name: AppRoutes.sampleDetails, page: () => const SampleDetailsScreen()),
    
    // Seller Routes
    GetPage(name: AppRoutes.sellerDashboard, page: () => const SellerHomeScreen()),
    GetPage(name: AppRoutes.sellerAddProduct, page: () => const SellerAddProductScreen()),
    GetPage(name: AppRoutes.sellerInventory, page: () => const SellerInventoryScreen()),
    GetPage(name: AppRoutes.sellerQuotations, page: () => const SellerQuotationsScreen()),
    GetPage(name: AppRoutes.sellerSamples, page: () => const SellerSamplesScreen()),
    GetPage(name: AppRoutes.sellerAnalytics, page: () => const SellerAnalyticsScreen()),
    GetPage(name: AppRoutes.sellerOrderDetails, page: () => const SellerOrderDetailsScreen()),
    GetPage(name: AppRoutes.sellerChat, page: () => const SellerChatScreen()),
    GetPage(name: AppRoutes.sellerNegotiation, page: () => const SellerNegotiationScreen()),
    
    // Admin Routes
    GetPage(name: AppRoutes.adminDashboard, page: () => const PlaceholderScreen(title: 'Admin Dashboard')),
  ];
}
