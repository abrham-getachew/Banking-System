import 'package:flutter/material.dart';
import '../presentation/add_investment_flow_step_1/add_investment_flow_step_1.dart';
import '../presentation/add_investment_flow_step_2/add_investment_flow_step_2.dart';
import '../presentation/add_investment_flow_step_3/add_investment_flow_step_3.dart';
import '../presentation/ai_chat_interface/ai_chat_interface.dart';
import '../presentation/ai_credit_health_tips/ai_credit_health_tips.dart';
import '../presentation/ai_dashboard/ai_dashboard.dart';
import '../presentation/auth/auth_screen.dart';
import '../presentation/blockchain_module_home/blockchain_module_home.dart';
import '../presentation/buy_sell_interface/buy_sell_interface.dart';
import '../presentation/credit_application_form/credit_application_form.dart';
import '../presentation/credit_eligibility_preview/credit_eligibility_preview.dart';
import '../presentation/crypto_trading_dashboard/crypto_trading_dashboard.dart';
import '../presentation/crypto_transaction_history/crypto_transaction_history.dart';
import '../presentation/digital_wallet/digital_wallet.dart';
import '../presentation/financial_goals/financial_goals.dart';
import '../presentation/how_it_works_tutorial/how_it_works_tutorial.dart';
import '../presentation/instant_credit_decision/instant_credit_decision.dart';
import '../presentation/investment_portfolio/investment_portfolio.dart';
import '../presentation/repayment_plan_selector/repayment_plan_selector.dart';
import '../presentation/risk_analysis_dashboard/risk_analysis_dashboard.dart';
import '../presentation/spending_habit_analyzer/spending_habit_analyzer.dart';
import '../presentation/tick_pay_dashboard/tick_pay_dashboard.dart';
import '../presentation/tick_pay_landing_page/tick_pay_landing_page.dart';
import '../presentation/token_detail_view/token_detail_view.dart';
import '../presentation/token_exchange/token_exchange.dart';
import '../presentation/transaction_history/transaction_history.dart';
import '../presentation/life_x_ecosystem/life_x_ecosystem.dart';
import '../presentation/nft_marketplace/nft_marketplace.dart';
import '../presentation/cryptocurrency_trading/cryptocurrency_trading.dart';
import '../presentation/money_transfer/money_transfer.dart';
import '../presentation/virtual_card_generator/virtual_card_generator.dart';
import '../presentation/wealth_summary_report/wealth_summary_report.dart';

class AppRoutes {
  // Authentication routes
  static const String authScreen = '/auth';

  // Main app routes
  static const String initial = '/';
  static const String digitalWallet = '/digital-wallet';
  static const String transactionHistory = '/transaction-history';
  static const String lifeXEcosystem = '/life-x-ecosystem';
  static const String nftMarketplace = '/nft-marketplace';
  static const String cryptocurrencyTrading = '/cryptocurrency-trading';
  static const String moneyTransfer = '/money-transfer';

  static const String blockchainModuleHome = '/blockchain-module-home';
  static const String cryptoTradingDashboard = '/crypto-trading-dashboard';
  static const String tokenExchange = '/token-exchange';
  static const String tokenDetailView = '/token-detail-view';
  static const String buySellInterface = '/buy-sell-interface';
  static const String cryptoTransactionHistory = '/crypto-transaction-history';

  static const String tickPayLandingPage = '/tick-pay-landing-page';
  static const String howItWorksTutorial = '/how-it-works-tutorial';
  static const String creditEligibilityPreview = '/credit-eligibility-preview';
  static const String instantCreditDecision = '/instant-credit-decision';
  static const String creditApplicationForm = '/credit-application-form';
  static const String repaymentPlanSelector = '/repayment-plan-selector';
  static const String virtualCardGenerator = '/virtual-card-generator';
  static const String tickPayDashboard = '/tick-pay-dashboard';
  static const String aiCreditHealthTips = '/ai-credit-health-tips';

  static const String aiDashboard = '/ai-dashboard';
  static const String addInvestmentFlowStep1 = '/add-investment-flow-step-1';
  static const String addInvestmentFlowStep2 = '/add-investment-flow-step-2';
  static const String addInvestmentFlowStep3 = '/add-investment-flow-step-3';
  static const String investmentPortfolio = '/investment-portfolio';
  static const String aiChatInterface = '/ai-chat-interface';
  static const String riskAnalysisDashboard = '/risk-analysis-dashboard';
  static const String financialGoals = '/financial-goals';
  static const String wealthSummaryReport = '/wealth-summary-report';
  static const String spendingHabitAnalyzer = '/spending-habit-analyzer';

  static Map<String, WidgetBuilder> routes = {
    authScreen: (context) => const AuthScreen(),
    initial: (context) => const AuthScreen(),
    digitalWallet: (context) => const DigitalWallet(),
    transactionHistory: (context) => const TransactionHistory(),
    lifeXEcosystem: (context) => const LifeXEcosystem(),
    nftMarketplace: (context) => const NftMarketplace(),
    cryptocurrencyTrading: (context) => const CryptocurrencyTrading(),
    moneyTransfer: (context) => const MoneyTransfer(),
    blockchainModuleHome: (context) => const BlockchainModuleHome(),
    cryptoTradingDashboard: (context) => const CryptoTradingDashboard(),
    tokenExchange: (context) => const TokenExchange(),
    tokenDetailView: (context) => const TokenDetailView(),
    buySellInterface: (context) => const BuySellInterface(),
    cryptoTransactionHistory: (context) => const CryptoTransactionHistory(),
    tickPayLandingPage: (context) => const TickPayLandingPage(),
    howItWorksTutorial: (context) => const HowItWorksTutorial(),
    creditEligibilityPreview: (context) => const CreditEligibilityPreview(),
    instantCreditDecision: (context) => const InstantCreditDecision(),
    creditApplicationForm: (context) => const CreditApplicationForm(),
    repaymentPlanSelector: (context) => const RepaymentPlanSelector(),
    virtualCardGenerator: (context) => const VirtualCardGenerator(),
    tickPayDashboard: (context) => const TickPayDashboard(),
    aiCreditHealthTips: (context) => const AiCreditHealthTips(),
    aiDashboard: (context) => const AiDashboard(),
    addInvestmentFlowStep1: (context) => const AddInvestmentFlowStep1(),
    addInvestmentFlowStep2: (context) => const AddInvestmentFlowStep2(),
    addInvestmentFlowStep3: (context) => const AddInvestmentFlowStep3(),
    investmentPortfolio: (context) => const InvestmentPortfolio(),
    aiChatInterface: (context) => const AiChatInterface(),
    riskAnalysisDashboard: (context) => const RiskAnalysisDashboard(),
    financialGoals: (context) => const FinancialGoals(),
    wealthSummaryReport: (context) => const WealthSummaryReport(),
    spendingHabitAnalyzer: (context) => const SpendingHabitAnalyzer(),
  };
}
