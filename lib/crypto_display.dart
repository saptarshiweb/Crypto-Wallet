import 'dart:convert';

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
  Color bgColor = const Color.fromARGB(255, 11, 0, 17);

  String url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=7d";

  Future<List<CryptoModel>> fetchCrypto() async {
    List<CryptoModel> list = [];
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
    print(responseData[0]);

    for (int i = 0; i < responseData[0].length; i++) {
      CryptoModel e1 = CryptoModel.fromJson(responseData[i]);
      print(i.toString());
      print(e1);
      list.add(e1);
    }

    return list;
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
      body: Column(
        children: [
          customAppBar(context),
          const SizedBox(height: 20),
          Expanded(
              child: SizedBox(
            height: 200,
            child: FutureBuilder(
                future: fetchCrypto(),
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Text(
                      'No data',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return tile(context, snapshot.data![index]);
                        });
                  }
                })),
          ))
        ],
      ),
    );
  }

  Widget tile(BuildContext context, CryptoModel model) {
    return Column(
      children: [
        Text(
          model.name!,
          style: const TextStyle(color: Colors.white),
        )
      ],
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
