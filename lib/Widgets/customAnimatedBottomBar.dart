import 'package:flutter/material.dart';

class customAnimatedBottomBar extends StatelessWidget {
  double device_hieght;
  List<BottomNavigationBarItem> items = [];
  ValueChanged<int> bottombaritem_selected;
  int selected_index;
  double device_width;
  customAnimatedBottomBar(
      {this.device_hieght = 0,
      required this.items,
      required this.bottombaritem_selected,
      required this.selected_index,
      this.device_width = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: (45 / 640) * device_hieght,
      width: device_width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35)),
      ),
      child: Container(
        width: device_width,
        margin: EdgeInsets.only(
          bottom: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () {
                bottombaritem_selected(index);
              },
              child: navItems(
                isSelected: index == selected_index ? true : false,
                item: item,
                device_hieght: device_hieght,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class navItems extends StatelessWidget {
  bool isSelected;
  BottomNavigationBarItem item;
  double device_hieght;
  navItems(
      {this.isSelected = false, required this.item, this.device_hieght = 0});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      height: (30 / 640) * device_hieght,
      width: isSelected ? 87 : 30,

      // padding: isSelected?EdgeInsets.only(left: 7):EdgeInsets.zero,
      // margin: isSelected?EdgeInsets.only(right: 10):EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffE2F1FA) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: isSelected ? 87 : 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: item.icon,
              ),
              if (isSelected)
                Container(
                  child: Text(item.label!),
                )
            ],
          ),
        ),
      ),
    );
  }
}
