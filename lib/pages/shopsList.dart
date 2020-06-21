import 'package:anywhere_hospital/pages/registerStore.dart';
import 'package:anywhere_hospital/pages/storeDetails.dart';
import 'package:anywhere_hospital/pages/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ShopsListPage extends StatefulWidget {
  static final String tag = '';
  final String uid;
  ShopsListPage({this.uid});

  @override
  _ShopsListPageState createState() => _ShopsListPageState();
}

class _ShopsListPageState extends State<ShopsListPage> {
  List<DocumentSnapshot> data;
  bool _loaded = false;
  @override
  void initState(){
    super.initState();
    Firestore.instance.collection('stores').getDocuments().then((value){
      setState(() {
        _loaded = false;
      });
      setState(() {
        data = value.documents;
      });
      setState(() {
        _loaded = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacies',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          _loaded ? FlatButton(
            child: Icon(Icons.map , color: Theme.of(context).primaryColorDark,),
            onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MapPage(data: data))),
          ):SizedBox(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
                          child: Card(
                color: Theme.of(context).primaryColorLight,
                child: Row(
                  children: <Widget>[
                    Image.asset(
                    'assets/images/register_store.png',
                    fit: BoxFit.fill,
                    height: 200.0,
                  ),
                  Text('Register your\nyour store with us\nand accelarate your\nyour way to\nsuccess.',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                  )
                  ],
                ),
              ),
              onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new RegisterStorePage(uid: this.widget.uid))),
            ),
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('stores').snapshots(),
            builder: (context , snapshot){
              return !snapshot.hasData ? LinearProgressIndicator() :
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                                              child: Card(
                          color: Theme.of(context).primaryColorDark,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image(image: AssetImage('assets/images/store.png'),),
                            ),
                            title: Text('${snapshot.data.documents[index]['storeName']}',
                              style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new StoreDetailsPage(data: snapshot.data.documents[index]))),
                      ),
                    );
                  },
                );
            },
          ),
        ],
      ),
    );
  }
}