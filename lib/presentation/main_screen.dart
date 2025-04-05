import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<IconData> socialIcons = [
    Icons.facebook,
    Icons.video_library,
    Icons.clear,
    Icons.more_horiz,
    Icons.video_call,
    Icons.extension,
    Icons.camera_alt,
    Icons.more_vert,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF2D6B5F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/logo.png')),
                    const SizedBox(width: 10),
                    const Text("Logo here", style: TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    _buildNotificationIcon(Icons.verified, 13),
                    const SizedBox(width: 10),
                    _buildNotificationIcon(Icons.notifications, 13),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [_WalletInfo(title: 'My Wallet', value: '\$ 350'), _WalletInfo(title: 'My Coins', value: '1,234,567')],
                ),
              ),

              // Social Icons Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: List.generate(socialIcons.length, (index) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(socialIcons[index], size: 30, color: Colors.black),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              _searchField(),

              _dropdownSection(),

              _textField(label: "Link", hint: "Paste your link here", hasPaste: true),

              _quantitySection(),

              const SizedBox(height: 20),
              const Text("Total: \$10000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue)),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Order Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF2D6B5F),
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Top-Up"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: Colors.green, child: const Icon(Icons.add, size: 32)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNotificationIcon(IconData icon, int count) {
    return Stack(
      children: [
        Icon(icon, color: Colors.white),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
            child: Text("$count", style: const TextStyle(fontSize: 10, color: Colors.black)),
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Services...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _dropdownSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            value: "Instagram Followers Service - Refill 30 Days Guarantee",
            items: ["Instagram Followers Service - Refill 30 Days Guarantee"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (_) {},
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 10),
          const Text("Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            value: "Instagram Followers Service - Refill 30 Days Guarantee",
            items:
                ["Instagram Followers Service - Refill 30 Days Guarantee"]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                              child: const Text("ID: 1323113", style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(e)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (_) {},
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );
  }

  Widget _textField({required String label, required String hint, bool hasPaste = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextField(decoration: InputDecoration(hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              ),
              if (hasPaste) const SizedBox(width: 10),
              if (hasPaste) ElevatedButton(onPressed: () {}, child: const Text("Paste")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "100", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Min: 100", style: TextStyle(fontStyle: FontStyle.italic)),
              Text("Max: 1000000", style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletInfo extends StatelessWidget {
  final String title;
  final String value;

  const _WalletInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.account_balance_wallet, color: Colors.amber, size: 30),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
