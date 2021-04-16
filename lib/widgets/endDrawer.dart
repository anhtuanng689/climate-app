import 'package:flutter/material.dart';

class endDrawer extends StatelessWidget {
  final wData;

  endDrawer({this.wData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              // color: Colors.lightGreen,
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add city',
                          style: _style1,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.widgets,
                    size: 30,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(6, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      'Add city',
                      style: _style1,
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    indent: 25,
                    endIndent: 25,
                  ),
                  SizedBox(
                    child: Text(
                      'Add city',
                      style: _style1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
