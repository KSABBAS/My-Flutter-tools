import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(MaterialApp(home: App(),debugShowCheckedModeBanner: false,));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? qrResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: 'Scan QR Code',
              onTap: () async {
                final result = await scanQR(context);
                if (result != null) {
                  setState(() {
                    qrResult = result;
                  });
                  print('Scanned QR Code: $result');
                }
              },
            ),
            if (qrResult != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Scanned Result: $qrResult'),
              ),
          ],
        ),
      ),
    );
  }
}
