import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_forward_crypto_app/crypto_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = const Color.fromARGB(255, 11, 0, 17);
  TextEditingController money = TextEditingController();
  bool transactionShow = false;
  List<double> array = [];

  double balance = 5000;
  bool flag = false;
  String tranasactionType = '';

  addTransaction(BuildContext context) {
    setState(() {
      if (tranasactionType == 'receive' || tranasactionType == 'add') {
        balance = balance + double.parse(money.text);
      } else {
        balance = balance - double.parse(money.text);
      }
      array.add(double.parse(money.text));
      flag = true;
      money.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: bgColor, // Navigation bar
          statusBarColor: bgColor, // Status bar
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(EvaIcons.gridOutline,
                          color: Colors.white, size: 32)),
                  const Text(
                    'Crypto Wallet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(EvaIcons.bulbOutline,
                          color: Colors.white, size: 32)),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Wallet Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Rs. $balance",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade600,
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  transactionShow = true;
                                  tranasactionType = 'receive';
                                });
                              },
                              icon: const Icon(
                                  EvaIcons.diagonalArrowLeftDownOutline,
                                  color: Colors.white,
                                  size: 32)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Receive",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade600,
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  transactionShow = true;
                                  tranasactionType = 'add';
                                });
                              },
                              icon: const Icon(EvaIcons.plusCircleOutline,
                                  color: Colors.white, size: 32)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade600,
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  transactionShow = true;
                                  tranasactionType = 'send';
                                });
                              },
                              icon: const Icon(
                                  EvaIcons.diagonalArrowLeftUpOutline,
                                  color: Colors.white,
                                  size: 32)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade600),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CryptoDisplay()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Crypto Exchange',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(Icons.navigate_next_outlined,
                                  color: Colors.white, size: 22)
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              (transactionShow == true)
                  ? transaction(context)
                  : const SizedBox(),
              const SizedBox(height: 20),
              (flag == true)
                  ? SizedBox(
                      height: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: array.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: transactionTile(context,
                                        array[index].toString(), index),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionTile(BuildContext context, String value, int index) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.deepPurpleAccent.shade700, width: 1.2),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Transaction Value",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        array.removeAt(index);
                        balance = balance - double.parse(value);
                      });
                    },
                    icon: const Icon(Icons.delete_forever_rounded,
                        color: Colors.white, size: 22))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Rs. $value",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget transaction(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade600,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Add Transaction Amount",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        transactionShow = false;
                      });
                    },
                    icon:
                        const Icon(Icons.cancel, color: Colors.black, size: 22))
              ],
            ),
            TextField(
              controller: money,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Transaction Value',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        addTransaction(context);
                        setState(() {
                          transactionShow = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
