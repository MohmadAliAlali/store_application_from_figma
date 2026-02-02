import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_button.dart';

class NoteficationScreen extends StatelessWidget {
  const NoteficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: GlobalColor.backgroundPage,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: ScreenUtil.getWidth(136),
          height: ScreenUtil.getHeight(46),
          alignment: Alignment.center,
          child: Text(
            'Notifications',
            style: TextStyle(
              fontSize: ScreenUtil.getWidth(16),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: GlobalColor.backgroundPage,
        leading: Navigator.canPop(context)
            ? CustomIcon(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: GlobalColor.iconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : CustomIcon(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: GlobalColor.iconColor,
                ),
                onPressed: () {},
              ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil.getWidth(20)),
            child: SizedBox(
              child: CustomIconAction(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline_outlined,
                  size: ScreenUtil.getWidth(24),
                ),
              ),
            ),
          )
        ],
      ),
      body: const Center(child: Text('Not have any notefication.',style: GlobalTextStyle.subheading,))
    );
  }
}
