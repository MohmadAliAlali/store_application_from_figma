import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/responsiv/risponsive.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Icon favorites;

  final double price;
  final VoidCallback onAddPressed;
  final VoidCallback onFavourite;
  final VoidCallback onclick;
  final double width;
  final double height;
  final Widget widget;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.onFavourite,
    required this.onAddPressed,
    required this.favorites,
    this.width = 157,
    this.height = 199,
    required this.onclick,
    required this.widget ,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
        onTap: onclick,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil.getWidth(12), ScreenUtil.getHeight(12), 0, 0),
          width: ScreenUtil.getWidth(width),
          height: ScreenUtil.getHeight(height),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil.getWidth(16)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IgnorePointer(
                      ignoring: false,
                      child: InkWell(
                        onTap: onFavourite,
                        child: favorites,
                      )),
                  Image.asset(imageUrl,
                      width: ScreenUtil.getHeight(93),
                      height: ScreenUtil.getHeight(95)),
                ],
              ),
              SizedBox(
                height: ScreenUtil.getHeight(12),
              ),
              SizedBox(
                height: ScreenUtil.getHeight(16),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: ScreenUtil.getWidth(12),
                    fontWeight: FontWeight.w500,
                    color: GlobalColor.greenButton,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getHeight(4),
              ),
              SizedBox(
                height: ScreenUtil.getHeight(20),
                child: Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: ScreenUtil.getWidth(12),
                    fontWeight: FontWeight.w600,
                    color: GlobalColor.gray,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ $price',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: ScreenUtil.getWidth(14),
                      fontWeight: FontWeight.w500,
                      color: GlobalColor.black,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: widget,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomAddIcon extends StatelessWidget {
  final VoidCallback onAddPressed;

  const CustomAddIcon(this.onAddPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return InkWell(
      onTap: onAddPressed,
      child: Container(
        width: ScreenUtil.getWidth(34),
        height: ScreenUtil.getHeight(34),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenUtil.getWidth(15)),
              bottomRight: Radius.circular(ScreenUtil.getWidth(15)),
            )),
        child: Icon(
          Icons.add,
          size: ScreenUtil.getWidth(12),
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomColorIcon extends StatelessWidget {

  const CustomColorIcon( {super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      width: ScreenUtil.getWidth(50),
      height: ScreenUtil.getHeight(34),
      decoration: const BoxDecoration(
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures spacing between circles
        children: [
          Container(
            width: ScreenUtil.getWidth(10),  // Width of the red circle
            height: ScreenUtil.getHeight(10), // Height of the red circle
            decoration:const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: ScreenUtil.getWidth(10),  // Width of the blue circle
            height: ScreenUtil.getHeight(10), // Height of the blue circle
            decoration:const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: ScreenUtil.getWidth(5),)
        ],
      ),
    );
  }
}
