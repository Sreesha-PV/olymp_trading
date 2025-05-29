import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../provider/balance_provider.dart';
import '../provider/selected_account_provider.dart';

class AccountDrawer extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AccountDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  List<int> _expandedAccounts = [];
  

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedAccounts.contains(index)) {
        _expandedAccounts.remove(index);
      } else {
        _expandedAccounts.add(index);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 360,
      backgroundColor: AppColors.bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            _buildHeader(context),
            const SizedBox(height: 30),
            Consumer<BalanceProvider>(
              builder: (context, balanceProvider, child) {
                if (balanceProvider.balance == null &&
                    !balanceProvider.isLoading) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // balanceProvider.loadBalance();
                    balanceProvider.loadBalance(context);
                  });
                }

                print(
                    "Got the balance in consumer ${balanceProvider.balance?.availableBalance}");

                return _buildAccountButton(
                  context,
                  'Demo Account',
                  0,
                  balanceProvider.balance != null
                      ? "Ð${balanceProvider.balance?.availableBalance}"
                      : "Loading...",
                );
              },
            ),
            const SizedBox(height: 20),
            _buildAccountButton(context, 'AED Account', 1, 'AED 0.00',
                expandable: true),
            const SizedBox(height: 20),
            _buildAccountButton(context, 'USDT Account', 2, "USDT 0.00",
                expandable: true),
            const SizedBox(height: 20),
            _buildAccountButton(context, '+ Add Account', 3, "",
                isAddButton: true),
          ],
        ),
      ),
    );
  }
 
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Accounts',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: AppColors.textColor),
        ),
      ],
    );
  }

  Widget _buildAccountButton(
    BuildContext context,
    String label,
    int index,
    String balance, {
    bool isAddButton = false,
    bool expandable = false,
  }) {
    final bool isExpanded = _expandedAccounts.contains(index);
    final selectedAccountNotifier =
        Provider.of<SelectedAccountNotifier>(context);
    final isSelected = selectedAccountNotifier.selectedAccount == label;

    return Column(
      children: [
        InkWell(
          // onTap: () {
          //   if (isAddButton) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text("Add Account clicked")),
          //     );
          //   } else {
          //     _toggleExpansion(index);
          //     selectedAccountNotifier.selectAccount(label);
          //   }
          // },

          onTap: (){
            if(isAddButton){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Add Account Clicked"))
              );
            }else{
              _toggleExpansion(index);
              if(index==0){
                final balance = Provider.of<BalanceProvider>(context,listen: false).balance;
                 final formattedBalance = balance != null
                  ? "Ð${balance.availableBalance?.toStringAsFixed(2)}"
                  : "Ð0.00";
              selectedAccountNotifier.selectAccount(label, formattedBalance);
              } else{
                selectedAccountNotifier.selectAccount(label);
              }
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: isExpanded ? AppColors.fillColor : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              children: [
                if (index == 0)
                  const Icon(Icons.account_balance_wallet,
                      color: Colors.orangeAccent),
                if (index == 0) const SizedBox(width: 10),
                _buildAccountInfo(context, label, balance, isSelected),
                const Spacer(),
                if (expandable)
                  const Icon(Icons.more_vert, color: AppColors.textColor),
              ],
            ),
          ),
        ),
        if (isExpanded && expandable) _buildExpandableActions(),
      ],
    );
  }

  Widget _buildAccountInfo(
      BuildContext context, String label, String balance, bool isSelected) {
    final selectedAccountNotifier =
        Provider.of<SelectedAccountNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        if (balance.isNotEmpty)
          Text(
            isSelected ? selectedAccountNotifier.selectedBalance : balance,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
  Widget _buildExpandableActions() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          _buildWithdrawButton(),
          const SizedBox(width: 10),
          _buildDepositButton(),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          foregroundColor: AppColors.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          minimumSize: const Size(100, 50),
        ),
        child: const Text("Withdraw"),
      ),
    );
  }

  Widget _buildDepositButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 76, 238, 238),
              Color.fromARGB(255, 74, 231, 43),
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Deposit clicked")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            minimumSize: const Size(120, 50),
          ),
          child: const Text(
            "Deposit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
