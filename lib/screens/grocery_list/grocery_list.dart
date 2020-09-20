import 'package:flutter/material.dart';

import 'package:housekeeping/components/nav_drawer.dart';
import 'package:housekeeping/models/item.dart';
import 'package:housekeeping/services/item_service.dart';

class GroceryListScreen extends StatefulWidget {
  static final String routeName = "/grocery_list";

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<Item> itemList = [];
  ItemService itemService = new ItemService();
  Item removedItem;

  @override
  void initState() {
    super.initState();

    // Load items
    itemService.getItems().then((items) {
      setState(() {
        itemList = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einkaufsliste"),
      ),
      drawer: NavDrawer(),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: itemListTileBuilder,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddItemDialog(context);
        },
      ),
    );
  }

  Widget itemListTileBuilder(context, index) {
    final item = itemList[index];
    return Dismissible(
      key: Key(item.name),
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 10),
        color: Colors.red[600],
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.cancel),
        ),
      ),
      child: ListTile(
        title: Text('${item.name}'),
      ),
      onDismissed: (direction) {
        removedItem = itemList[index];
        setState(() {
          itemService.removeItem(removedItem).then((items) {
            itemList = items;
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${removedItem.name} gelöscht.'),
              action: SnackBarAction(
                label: "Rückgängig",
                onPressed: () => setState(() {
                  itemService.addItem(removedItem).then((items) => itemList = items);
                }),
              ),
            ));
          });
        });
      },
    );
  }

  showAddItemDialog(BuildContext context) {
    Item _item;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: Text("Erstellen"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Bitte einen Text eingeben";
                }
                return null;
              },
              onSaved: (newValue) => _item = new Item.fromName(newValue),
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Hinzufügen"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  setState(() {
                    itemService.addItem(_item).then((items) {
                      itemList = items;
                      Navigator.of(context).pop();
                    });
                  });
                }
              },
            )
          ],
        );
      },
    );
  }
}
