import 'package:cours_dar_2024/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final bool? hideTextButton;
  final double height;
  final double width;

  const CardWidget({super.key, required this.onPressed, this.hideTextButton = false, required this.height, required this.width});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: const AssetImage(imgBg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.srcIn))),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            height: 140,
            width: 135,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: PrettyQrView.data(
                    data: 'google.com',
                  )),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.hideTextButton!
                      ? const SizedBox.shrink()
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Scanner")
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
