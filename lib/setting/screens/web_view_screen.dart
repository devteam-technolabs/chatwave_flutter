import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewScreen extends StatelessWidget {
  final String url;
  final String name;

  WebViewScreen({super.key, required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 1.sw,
            color: ColorConstants.c1F61E8,
            padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(context: context),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(width: 0.1.sw,),
              ],
            ),
          ),
          space05(),
          Expanded(
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                  ),
                )
                ..loadRequest(Uri.parse(url)),
            ),
          )
        ],
      ),
    );
  }
}
