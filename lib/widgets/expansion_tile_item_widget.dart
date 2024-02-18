import 'package:flutter/material.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.initExpaded = false,
  }) {
    controller = ExpansionTileController();
  }

  String expandedValue;
  String headerValue;
  bool initExpaded;

  late ExpansionTileController controller;
  bool get isExpanded => controller.isExpanded;
}

class ExpansionPanelListExample extends StatefulWidget {
  final String myDay;
  final String myYear;

  final String myDayText;
  final String myYearText;

  const ExpansionPanelListExample(
      {Key? key,
      required this.myDayText,
      required this.myYearText,
      required this.myDay,
      required this.myYear})
      : super(key: key);

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  late List<Item> _data;

  @override
  void initState() {
    super.initState();
    _data = [
      Item(
        headerValue: 'Сьогодні ваш день: ${widget.myDay}',
        expandedValue: widget.myDayText,
        initExpaded: true,
      ),
      Item(
        headerValue: 'Ваш персональний рік: ${widget.myYear}',
        expandedValue: widget.myYearText,
      )
    ];
  }

  void onExpansionChanged(bool isExpanded, int index) {
    for (var element in _data) {
      final isCurrent = _data.indexOf(element) == index;

      /// Якщо нове значення "розгортати == true" і це поточний елемент, то розгорнути його
      /// та якщо це не поточний елемент, то згортаємо його.
      /// Але якщо "розгортати == false", то згортаємо тіки поточний елемент.
      if (isExpanded) {
        if (isCurrent) {
          element.controller.expand();
        } else {
          element.controller.collapse();
        }
      } else {
        if (isCurrent) {
          element.controller.collapse();
        }
      }
      // } else {
      //   element.controller.collapse();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: _data
              .map((e) => ExpansionTileItemWidget(
                    item: e,
                    onExpansionChanged: (isExpanded) =>
                        onExpansionChanged(isExpanded, _data.indexOf(e)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ExpansionTileItemWidget extends StatefulWidget {
  const ExpansionTileItemWidget({
    super.key,
    required this.item,
    required this.onExpansionChanged,
  });

  final Item item;
  final void Function(bool isExpanded) onExpansionChanged;

  @override
  State<ExpansionTileItemWidget> createState() =>
      _ExpansionTileItemWidgetState();
}

class _ExpansionTileItemWidgetState extends State<ExpansionTileItemWidget> {
  late final Item item;
  late bool isExpanded;

  @override
  initState() {
    super.initState();
    item = widget.item;
    isExpanded = item.initExpaded;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: item.controller,
      initiallyExpanded: item.initExpaded,
      onExpansionChanged: (newiIsExpanded) {
        widget.onExpansionChanged(newiIsExpanded);
        setState(() {
          isExpanded = newiIsExpanded;
        });
      },
      title: Text(
        item.headerValue,
        style: TextStyle(
          color: isExpanded ? 
            Theme.of(context).colorScheme.secondary : 
            Theme.of(context).colorScheme.onPrimary,
          fontWeight: isExpanded ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Text(item.expandedValue),
        ),
      ],
    );
  }
}
