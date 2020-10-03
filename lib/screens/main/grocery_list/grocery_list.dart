import 'package:flutter/material.dart';

import 'package:housekeeping/widgets/nav_drawer.dart';
import 'package:housekeeping/models/user_data.dart';
import 'package:housekeeping/models/item.dart';
import 'package:housekeeping/services/item_service.dart';

class GroceryListScreen extends StatefulWidget {
  static const String routeName = "/grocery_list";

  const GroceryListScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  bool _loading = true;
  List<Item> itemList = [];
  ItemService itemService = ItemService();
  Item removedItem;

  @override
  void initState() {
    super.initState();

    // Load items
    itemService.getItems().then((items) {
      setState(() {
        _loading = false;
        itemList = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery list"),
      ),
      drawer: NavDrawer(user: widget.user),
      body: _loading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
              itemCount: itemList.length,
              itemBuilder: itemListTileBuilder,
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showAddItemDialog(context),
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
        itemService.removeItem(removedItem).then((items) {
          if (mounted)
            setState(() {
              itemList = items;
            });
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${removedItem.name} gelöscht.'),
              action: SnackBarAction(
                label: "Rückgängig",
                onPressed: () => itemService.addItem(removedItem).then((items) {
                  setState(() {
                    itemList = items;
                  });
                }),
              ),
            ),
          );
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
              validator: (String value) {
                if (value.isEmpty) {
                  return "Bitte einen Text eingeben";
                }
                return null;
              },
              onSaved: (newValue) => _item = Item.fromName(newValue),
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Abbrechen"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("Hinzufügen"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  itemService.addItem(_item).then((items) {
                    setState(() {
                      itemList = items;
                    });
                    Navigator.pop(context);
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
