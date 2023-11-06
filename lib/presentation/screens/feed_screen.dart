import 'package:flutter/material.dart';

const _maxHeaderHeight = 250.0;
const _minHeaderHeight = 56.0;
const _bodyContentRatioMin = .8;
const _bodyContentRatioMax = 1.0;
// Must be between min and max values of body content ratio.
const _bodyContentRatioParallax = .9;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
  final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);

  @override
  void dispose() {
    headerNegativeOffset.dispose();
    appbarShadow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0.0,
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<double>(
              valueListenable: headerNegativeOffset,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: Offset(0, offset * -1),
                  child: SizedBox(
                    height: _maxHeaderHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent == _bodyContentRatioMin) {
                appbarShadow.value = false;
                headerNegativeOffset.value = 0;
              } else if (notification.extent == _bodyContentRatioMax) {
                appbarShadow.value = true;
                headerNegativeOffset.value =
                    _maxHeaderHeight - _minHeaderHeight;
              } else {
                double newValue = (_maxHeaderHeight - _minHeaderHeight) -
                    ((_maxHeaderHeight - _minHeaderHeight) *
                        ((_bodyContentRatioParallax - (notification.extent)) /
                            (_bodyContentRatioMax -
                                _bodyContentRatioParallax)));
                appbarShadow.value = false;
                if (newValue >= _maxHeaderHeight - _minHeaderHeight) {
                  appbarShadow.value = true;
                  newValue = _maxHeaderHeight - _minHeaderHeight;
                } else if (newValue < 0) {
                  appbarShadow.value = false;
                  newValue = 0;
                }
                headerNegativeOffset.value = newValue;
              }
              return true;
            },
            child: Stack(
              children: <Widget>[
                DraggableScrollableSheet(
                  initialChildSize: _bodyContentRatioMin,
                  minChildSize: _bodyContentRatioMin,
                  maxChildSize: _bodyContentRatioMax,
                  builder: (
                    BuildContext context,
                    ScrollController scrollController,
                  ) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                          ),
                          child: Material(
                            type: MaterialType.canvas,
                            color: Colors.white,
                            elevation: 2.0,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: 200,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(title: Text('Item $index'));
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: ValueListenableBuilder<bool>(
                valueListenable: appbarShadow,
                builder: (context, value, child) {
                  // Default height of appbar is 56.0. We can also
                  // use a custom widget and height if needed.
                  return AppBar(
                    backgroundColor: Colors.orange,
                    title: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Local activities",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              "What To Do?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    elevation: value ? 2.0 : 0.0,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
