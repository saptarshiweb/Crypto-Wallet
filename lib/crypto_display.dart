import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'crypto_model.dart';

class CryptoDisplay extends StatefulWidget {
  const CryptoDisplay({super.key});

  @override
  State<CryptoDisplay> createState() => _CryptoDisplayState();
}

class _CryptoDisplayState extends State<CryptoDisplay> {
  List<String> name = [];
  List<String> image = [];
  List<String> price = [];
  List<String> change = [];
  Color bgColor = const Color.fromARGB(255, 11, 0, 17);
  TextEditingController controller = TextEditingController();
  int selectedIndex = 0;

  bool showCryptoData = false;
  bool showTransactionData = true;

  bool showBuyOption = false;

  String url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d";

  fetchCrypto() async {
    List<CryptoModel> list = [];
    print('hello');
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Access-Control-Allow-Origin': '*',
        // 'Access-Control-Allow-Credentials': 'true',
        // 'Access-Control-Allow-Headers': 'Content-Type',
        // 'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
      },
    );

    var responseData = json.decode(response.body);
    print(responseData);

    for (int i = 0; i < responseData.length; i++) {
      setState(() {
        name.add(responseData[i]['name']);
        image.add(responseData[i]['image']);
        price.add(responseData[i]['current_price'].toString());
      });
    }
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            customAppBar(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (showCryptoData == true)
                            ? Colors.purple.shade900
                            : bgColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          showCryptoData = true;
                          showTransactionData = false;
                        });

                        fetchCrypto();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          'Fetch Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (showTransactionData == true)
                            ? Colors.purple.shade900
                            : bgColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          showCryptoData = false;
                          showTransactionData = true;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          'Transactions',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            (showBuyOption == true) ? buyCrypto(context) : const SizedBox(),
            const SizedBox(height: 10),
            (showCryptoData == true)
                ? Expanded(
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: name.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.8,
                                        color: Colors.purple.shade700),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            width: 40,
                                            child: Image.network(
                                              image[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            name[index],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "\$ ${price[index]}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .deepPurple.shade600),
                                              onPressed: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                  showBuyOption = true;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  'Buy ${name[index]}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buyCrypto(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple.shade900, width: 1.5),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Buy ${name[selectedIndex]}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showBuyOption = false;
                      });
                    },
                    icon: const Icon(EvaIcons.closeCircleOutline,
                        color: Colors.white, size: 32)),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(color: Colors.purple.shade900, width: 2)),
                  labelText: 'Enter Amount to be purchased',
                  labelStyle: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade600),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.navigate_before_rounded,
                color: Colors.white, size: 40)),
        const Text(
          'Crypto Exchanges',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.help, color: Colors.white, size: 26)),
      ],
    );
  }
}
