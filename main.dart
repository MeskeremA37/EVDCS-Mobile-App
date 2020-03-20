/*import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Product.dart';

void main() => runApp(MyApp(products: fetchProducts()));

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromMap(json)).toList();
}
Future<List<Product>> fetchProducts() async {
  final response = await http.get('http://10.240.73.22:8000/products.json');
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
class MyApp extends StatelessWidget {
  final Future<List<Product>> products;
  MyApp({Key key, this.products}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Product Navigation demo home page', products: products),
    );
  }
}
class MyHomePage extends StatelessWidget {
  final String title;
  final Future<List<Product>> products;
  MyHomePage({Key key, this.title, this.products}) : super(key: key);

  // final items = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Navigation")),
        body: Center(
          child: FutureBuilder<List<Product>>(
            future: products, builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ProductBoxList(items: snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          ),
        )
    );
  }
}
class ProductBoxList extends StatelessWidget {
  final List<Product> items;
  ProductBoxList({Key key, this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProductBox(item: items[index]),
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => ProductPage(item: items[index]),
            ),
            );
          },
        );
      },
    );
  }
}
class ProductPage extends StatelessWidget {
  ProductPage({Key key, this.item}) : super(key: key);
  final Product item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.item.name),),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/appimages/" + this.item.image),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style:
                            TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Price: " + this.item.price.toString()),
                            RatingBox(),
                          ],
                        )
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() =>_RatingBoxState();
}
class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;
  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });
  }
  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }
  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }
  Widget build(BuildContext context) {
    double _size = 20;
    print(_rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,

      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
                _rating >= 1
                    ? Icon(Icons.star, size: _size,)
                    : Icon(Icons.star_border, size: _size,)
            ),
            color: Colors.red[500], onPressed: _setRatingAsOne, iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
                _rating >= 2
                    ? Icon(Icons.star, size: _size,)
                    : Icon(Icons.star_border, size: _size, )
            ),
            color: Colors.red[500],
            onPressed: _setRatingAsTwo,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
                _rating >= 3 ?
                Icon(Icons.star, size: _size,)
                    : Icon(Icons.star_border, size: _size,)
            ),
            color: Colors.red[500],
            onPressed: _setRatingAsThree,
            iconSize: _size,
          ),
        ),
      ],
    );
  }
}
class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.item}) : super(key: key);
  final Product item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2), height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/appimages/" + this.item.image),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style:TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Price: " + this.item.price.toString()),
                            RatingBox(),
                          ],
                        )
                    )
                )
              ]
          ),
        )
    );
  }
}*/
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final String username;
  final String email;

  Post({ this.username, this.email});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(

      username: json['username'],
      email: json['email'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  String username = 'shems';
  String password = 'Jemal@12';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);


  return http.post(url, headers: <String, String>{'authorization': basicAuth},body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = "http://10.240.73.22:8000/users/";
  TextEditingController usernameControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create user'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: usernameControler,
                  decoration: InputDecoration(
                      hintText: "username....", labelText: 'username'),
                ),
                new TextField(
                  controller: emailControler,
                  decoration: InputDecoration(
                      hintText: "email....", labelText: 'email'),
                ),
                new RaisedButton(
                  onPressed: () async {
                    Post newPost = new Post(
                        username: usernameControler.text, email: emailControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.username);
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}

void main() => runApp(MyApp());