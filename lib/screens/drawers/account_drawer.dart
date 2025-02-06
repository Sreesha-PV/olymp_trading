import 'package:flutter/material.dart';

class AccountDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AccountDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            _buildAccountButton(context, 'AED Account', 1, "AED 0.00"),
            const SizedBox(height: 20),
            _buildAccountButton(context, 'USDT Account', 2, "USDT 0.00"),
            const SizedBox(height: 20),
            _buildAccountButton(context, '+ Add Account', 3, "", isAddButton: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountButton(BuildContext context, String label, int index, String balance, {bool isAddButton = false}) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        if (isAddButton) {
         
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Account clicked")),
          );
        } else {
          onSelect(index);
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[850] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
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
                  style: TextStyle(
                      color: Colors.white,
                      // AddButton ? Colors.greenAccent : Colors.white,
                      fontSize: 18,
                      fontWeight: isAddButton ? FontWeight.bold : FontWeight.normal),
                ),
                if (balance.isNotEmpty)
                  Text(
                    balance,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
              ],
            ),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.greenAccent),
          ],
        ),
      ),
    );
  }
}

