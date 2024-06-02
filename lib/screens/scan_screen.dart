import 'package:camera/camera.dart';
import 'package:cours_dar_2024/main.dart';
import 'package:cours_dar_2024/screens/home_screen.dart';
import 'package:cours_dar_2024/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;
  late PageController pageController;
  bool isFlashOn = false;
  bool isSwitch = false;
  int numPage = 0;

  @override
  void initState() {
    super.initState();
    initCamController();
    pageController = PageController(initialPage: numPage);
  }

  initCamController() {
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                cameraScan(),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: CardWidget(
                        height: 300,
                        width: 500,
                        onPressed: () {},
                        hideTextButton: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: numPage == 0 ? Colors.black : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                ),
                child: ToggleSwitch(
                  initialLabelIndex: numPage,
                  minWidth: 150,
                  cornerRadius: 35,
                  activeFgColor: numPage == 0 ? Colors.white : Colors.black,
                  inactiveFgColor: numPage == 0 ? Colors.white : Colors.black,
                  activeBgColor:
                  numPage == 0 ? const [Colors.grey] : const [Colors.white],
                  inactiveBgColor: numPage == 0 ? Colors.black : Colors.grey,
                  labels: const ["Scanner un code", "Ma carte"],
                  totalSwitches: 2,
                  radiusStyle: true,
                  onToggle: (index) {
                    setState(() {
                      numPage = index!;
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cameraScan() {
    return Stack(
      children: [
        AspectRatio(
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            child: CameraPreview(controller)),
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode
                        .dstOut), // This one will handle background + difference out
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                    controller.setFlashMode(
                        isFlashOn ? FlashMode.torch : FlashMode.off);
                  },
                  child: Icon(
                    isFlashOn ? Icons.flash_off : Icons.flash_on,
                    color: Colors.white,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
