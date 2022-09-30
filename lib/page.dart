import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;



class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State {
  final _textEditingController = TextEditingController();

  void submitWebRequest() {
    if (kDebugMode) {
      String text = _textEditingController.text;
      print("Going to UPC $text");
      
      String serverUrl = dotenv.get("SERVER_URL");
      Uri url = Uri.parse(serverUrl);

      //Map<String, String> body = new Map();
      //body.addEntries

      http.post(url, body: {'upc': text}).then((value) => {
        if (kDebugMode) {
          print(value)
        }
      });
    }

  }

  Future<void> goToScanner() async {
    String res = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);
    _textEditingController.text = res;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner")),
      body: Center(
          child: Column(
        children: [
          TextFormField(
            controller: _textEditingController,
          ),
          TextButton(
            onPressed: () => submitWebRequest(),
            child: const Text("Submit"),
          ),
          TextButton(
              onPressed: () => goToScanner(), child: const Text("Scanner"))
        ],
      )),
    );
  }
}
