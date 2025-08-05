import 'dart:async';

import 'package:flutter/cupertino.dart';

Future<void> showDialogLoading(BuildContext context , {String? msg}) async{
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  _AnimatedCupertinoLoader(msg);
    },
  );
}

class _AnimatedCupertinoLoader extends StatefulWidget {
   const _AnimatedCupertinoLoader(this.message);

  final String? message;

  @override
  State<_AnimatedCupertinoLoader> createState() => _AnimatedCupertinoLoaderState();
}

class _AnimatedCupertinoLoaderState extends State<_AnimatedCupertinoLoader> {
  late Timer _timer;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // cycle from 0 to 3
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = '.' * _dotCount;
    return CupertinoAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CupertinoActivityIndicator(radius: 15),
          const SizedBox(height: 16),
          Text('${widget.message ?? 'Loading'}$dots', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
