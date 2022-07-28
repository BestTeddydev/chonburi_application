import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final Widget gotoWidget;
  final String imageUrl;
  final String? title;
  final Color titleColor;
  const MenuCard({
    Key? key,
    required this.gotoWidget,
    required this.imageUrl,
    required this.title,
    required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => gotoWidget)),
        child: Stack(
          children: [
            SizedBox(
              height: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width * 1,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  title!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(0, 2.2),
                          blurRadius: 6,
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
