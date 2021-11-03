import 'package:abs_fitness/Components/BottomBar.dart';
import 'package:abs_fitness/admin_details_page/event.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Resources/Constants.dart';
import 'bloc.dart';
import 'state.dart';

// ignore: must_be_immutable
class AdminDetailsPage extends StatelessWidget {
  static final id = "AdminDetailsPage";
  final String planName;
  final ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  final AdminDetailsPageBloc ab = AdminDetailsPageBloc();
  bool isLeaving = false;
  AdminDetailsPage({this.planName});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        isLeaving = true;
        ab.add(LeavePageEvent());
      },
      child: BlocConsumer<AdminDetailsPageBloc, AdminDetailsPageState>(
        cubit: ab,
        builder: (context, state) {
          print(state.toString());
          if (state is UILoaded) {
            return initDetailsPage(context, state.loadedUIWidgets);
          } else if (state is LoadingUI) {
            return loadingWidget();
          } else {
            if (!isLeaving) {
              ab.add(LoadUIEvent(context, planName));
              return loadingWidget();
            } else
              return loadingWidget();
          }
        },
        listener: (context, state) {
          if (state is LeaveState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget initDetailsPage(BuildContext context, List<Widget> uiElements) {
    Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;

    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: Container(
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : categoryHeight,
                child: Container(
                  alignment: Alignment(0.0, -1.0),
                  height: size.height * 0.5,
                  padding: EdgeInsets.all(10),
                  color: Colors.white54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Image(
                          image: Image.asset("assets/abs.gif").image,
                          height: 100,
                          width: 150,
                        ),
                      ),
                      TypewriterAnimatedTextKit(
                        text: ['Absolute-Fitness'],
                        textStyle: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Request for $planName",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: uiElements.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  double scale = 1.0;
                  if (topContainer > 0.5) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return Opacity(
                    opacity: scale,
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.bottomCenter,
                      child: Align(
                          heightFactor: 0.7,
                          alignment: Alignment.topCenter,
                          child: Dismissible(
                              key: Key(index.toString()),
                              background: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                padding: EdgeInsets.all(10),
                                color: Colors.redAccent,
                                child: Icon(
                                  Icons.delete,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                ab.add(CloseRequestEvent(index, planName));
                              },
                              child: uiElements[index])),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
