import 'package:cours_dar_2024/models/transaction.dart';
import 'package:cours_dar_2024/screens/scan_screen.dart';
import 'package:cours_dar_2024/utils/constants.dart';
import 'package:cours_dar_2024/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = false;
  List<Transaction> transList = [];

  setVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    initJiffy();
    super.initState();
    transList.add(Transaction(
        title: "Retrait",
        amount: 15000,
        date: DateTime.now(),
        type: TransactionType.retrait));
    transList.add(Transaction(
        title: "Paiement Canal",
        amount: 5000,
        date: DateTime.now(),
        type: TransactionType.paiement));
    transList.add(Transaction(
        title: "Modou 77 777 77 77",
        amount: 10000,
        date: DateTime.now(),
        type: TransactionType.depot));
    transList.add(Transaction(
        title: "Mbaye 77 777 77 75",
        amount: 19000,
        date: DateTime.now(),
        type: TransactionType.transfert));

  }
  initJiffy() async {
    setState(() async {
      await Jiffy.setLocale('fr_ca');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: primaryColor,
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                pinned: true,
                expandedHeight: 110,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isVisible
                          ? RichText(
                              text: const TextSpan(
                                  text: "10.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                  TextSpan(
                                    text: "F",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]))
                          : const Text(
                              "•••••••",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setVisible();
                        },
                        child: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  centerTitle: true,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 2000,
                  child: Stack(
                    children: [
                      Container(
                        color: primaryColor,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 150),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                      ),
                      Column(
                        children: [
                          CardWidget(
                            height: 180,width:300,
                            onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ScanScreen();
                              },
                            ));
                          },),
                          GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              optionWidget(
                                  icon: Icons.person,
                                  title: "Transfert",
                                  color: Colors.purple,
                                  onTap: () {
                                    print("transfert");
                                  }),
                              optionWidget(
                                  icon: Icons.shopping_cart,
                                  title: "Paiements",
                                  color: Colors.orangeAccent,
                                  onTap: () {
                                    print("paiements");
                                  }),
                              optionWidget(
                                  icon: Icons.phone_android_outlined,
                                  title: "Crédit",
                                  color: Colors.blue,
                                  onTap: () {
                                    print("credit");
                                  }),
                              optionWidget(
                                  icon: Icons.account_balance,
                                  title: "Banque",
                                  color: Colors.red,
                                  onTap: () {
                                    print("banque");
                                  }),
                              optionWidget(
                                  icon: Icons.card_giftcard,
                                  title: "Cadeaux",
                                  color: Colors.green,
                                  onTap: () {
                                    print("cadeaux");
                                  }),
                            ],
                          ),
                          Divider(
                            thickness: 8,
                            color: Colors.grey.shade200,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: transList.length,
                            itemBuilder: (context, index) {
                              Transaction t = transList[index];
                              return transactionWidget(t);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget optionWidget(
      {required IconData icon,
      required String title,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: color.withOpacity(.3),
                borderRadius: BorderRadius.circular(60)),
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget transactionWidget(Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.title ?? "",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Text(
                "${transaction.type == TransactionType.retrait || transaction.type == TransactionType.transfert ? "-" : ""}${transaction.amount}F",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
          Text(
            Jiffy.parseFromDateTime(transaction.date!)
                .format(pattern: "dd MMMM yyyy à HH:mm"),
            style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
