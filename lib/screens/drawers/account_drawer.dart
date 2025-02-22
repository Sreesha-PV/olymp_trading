import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/provider/selected_account_notifier.dart';
import 'package:provider/provider.dart';


class AccountDrawer extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AccountDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  List<int> expandedAccounts = []; 

  void toggleExpansion(int index) {
    setState(() {
      if (expandedAccounts.contains(index)) {
        expandedAccounts.remove(index);
      } else {
        expandedAccounts.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 360,
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Accounts',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildAccountButton(context, 'Demo Account', 0, "Ð10,000.00"),
            const SizedBox(height: 20),
            _buildAccountButton(context, 'AED Account', 1, "AED 0.00", expandable: true),
            const SizedBox(height: 20),
            _buildAccountButton(context, 'USDT Account', 2, "USDT 0.00", expandable: true),
            const SizedBox(height: 20),
            _buildAccountButton(context, '+ Add Account', 3, "", isAddButton: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountButton(BuildContext context, String label, int index, String balance,
      {bool isAddButton = false, bool expandable = false}) {
    bool isExpanded = expandedAccounts.contains(index);
   final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);
    final isSelected = selectedAccountNotifier.selectedAccount == label;
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isAddButton) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Add Account clicked")),
              );
            } else {
              toggleExpansion(index);
              Provider.of<SelectedAccountNotifier>(context, listen: false)
          .selectAccount(label);
      // Navigator.pop(context); 
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: isExpanded ? Colors.grey[850] : Colors.transparent,
              // borderRadius: BorderRadius.circular(10),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              )
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              children: [
                if (index == 0) 
                  const Icon(Icons.account_balance_wallet, color: Colors.orangeAccent),
                if (index == 0) const SizedBox(width: 10), 

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18
                          // color: isAddButton ? Colors.greenAccent : Colors.white,
                          // fontSize: 18,
                          // fontWeight: isAddButton ? FontWeight.bold : FontWeight.normal
                          ),
                    ),
                    if (balance.isNotEmpty)
                      Text(
                        isSelected ? selectedAccountNotifier.selectedBalance : balance,
                        // balance,
                        style: const TextStyle(
                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                const Spacer(),
                if (expandable)
                  const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
        if (isExpanded && expandable)
        Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Withdraw clicked")),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text("Withdraw"),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 8),
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Deposit clicked")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        minimumSize: const Size(120, 50),
                      ),
                      child: const Text("Deposit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}



 