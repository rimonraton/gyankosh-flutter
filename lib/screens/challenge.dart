import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Challenge extends StatefulWidget {
  final Uri url;
  const Challenge({super.key, required this.url});

  @override
  State<Challenge> createState() => ChallengeState();

}
class ChallengeState extends State<Challenge>  {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Blue Screen'),
  //       centerTitle: true,
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text('Welcome to Flutter DeepLinking tutorial! ${widget.url}'),
  //           MaterialButton(
  //             onPressed: () => context.go('/'),
  //             color: Colors.red,
  //             child: const Text('Home'),
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: Colors.blue,
  //   );
  // }

  Widget build(BuildContext context) {
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.url);

    return Scaffold(
      appBar: AppBar(title: const Text('Gyankosh - Learn With Fun')),
      body: WebViewWidget(controller: webViewController),
    );
  }

}
