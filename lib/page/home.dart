import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/customer_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final stateProvider = Provider.of<CustomerModel>(context);

    /// Will used to access the Animated list
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          Consumer<CustomerModel>(builder: (context, data, child) {
            if (data.items.isNotEmpty) {
              return AnimatedList(
                key: listKey,
                initialItemCount: data.items.length,
                itemBuilder: (context, index, animation) {
                  return slideIt(context, data.items[index], animation);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              //labelText: 'Enter your username',
                              hintText: "Add Customer"),
                          controller: myController,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (myController.text.isNotEmpty) {
                            stateProvider.add(myController.text);
                            listKey.currentState?.insertItem(0,
                                duration: const Duration(milliseconds: 5));
                            myController.clear();
                          }
                        },
                        child: const Text('Add'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background
                          onPrimary: Colors.white, // foreground
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget slideIt(BuildContext context, String name, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: SizedBox(
        height: 128.0,
        child: Card(
          child: Center(
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
