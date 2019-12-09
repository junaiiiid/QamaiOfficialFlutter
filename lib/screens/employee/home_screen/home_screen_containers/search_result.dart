import 'package:flutter/material.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_bar.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_card.dart';


class SearchResultList extends StatelessWidget {
  const SearchResultList({
    Key key,
    @required this.tempSearchStore,
    this.item,
  }) : super(key: key);

  final List tempSearchStore;
  final item;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.all(0),
        primary: false,
        shrinkWrap: true,
        children: tempSearchStore.map((element) {

          if(item==1)
            {
              return SearchResultCards(element,'FullName','Story',context,item);
            }
          else if(item==2)
          {
            return SearchResultCards(
                element, 'EmployerName', 'EmployerTitle', context, item);
          }
          else{
            return SearchResultCards(
                element, 'EmployerName', 'EmployerTitle', context, item);
          }

        }).toList());
  }
}

