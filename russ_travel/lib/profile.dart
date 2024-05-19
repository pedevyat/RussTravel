import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';

class Profile extends StatefulWidget{

	ProfilePage createState()=> ProfilePage();
}

class SignIn extends StatefulWidget{
	final void Function(int) onPageChanged;
	SignIn(this.onPageChanged);
	SignInPage createState()=> SignInPage();
}

class SignUp extends StatefulWidget{
	final void Function(int) onPageChanged;
	SignUp(this.onPageChanged);
	SignUpPage createState()=> SignUpPage();
}

class Account extends StatefulWidget{
	final void Function(int) onPageChanged;
	Account(this.onPageChanged);
	AccountPage createState()=> AccountPage();
}

class MuseumsList extends StatefulWidget {
	final void Function(int) onPageChanged;
	MuseumsList(this.onPageChanged);
	MuseumListPage createState() => MuseumListPage();
}

class ParksList extends StatefulWidget {
	final void Function(int) onPageChanged;
	ParksList(this.onPageChanged);
	ParksListPage createState() => ParksListPage();
}

class OutsList extends StatefulWidget {
	final void Function(int) onPageChanged;
	OutsList(this.onPageChanged);
	OutsListPage createState() => OutsListPage();
}

class MuseumListPage extends State<MuseumsList> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    var _userData = await Hive.openBox('UserData');
    final response = await http.get(Uri.parse('https://russ-travel.onrender.com/get-museums?user_id=${int.parse(_userData.getAt(0))}'),
    headers: {
    'Content-Type': 'application/json; charset=UTF-8', // Указываем кодировку UTF-8
    });
    
    if (response.statusCode == 200) {
      	//final decodedResponse
      	List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      	setState(() {
	        items = data.cast<Map<String, dynamic>>();
      	});
      	/*for (int i = 0; i < items.length; i++)
      	{
      		items[i] =       	
      	}*/
      	isLoading = false;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPageChanged(2);
        return false;
      },
      child: isLoading ? SpinKitChasingDots(color: Colors.blue, size: 50.0) : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context); // Действие по нажатию кнопки "Назад"
            widget.onPageChanged(2);
          },
        ),
        title: Text('Посещённые музеи'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = items[index];
          String title = item['title'];

          return Dismissible(
            key: Key(title),
            onDismissed: (direction) async {
              var musbox = await Hive.openBox('museumBox');
              var _userData = await Hive.openBox('UserData');
              int ind = -1;
              for (int i = 0; i < items.length; i++)
              {
              	print(items[i]['title'] + " " +  title);
              	if (items[i]['title'] == title)
              	{
              		ind = items[i]['id'];
              		break;
              	}
              }
              musbox.delete(ind);
              final resp = await http.post(
		      Uri.parse('https://russ-travel.onrender.com/delete-museum?id=${ind}&user_id=${int.parse(_userData.getAt(0))}'),
		      headers: {
	      			'accept': 'application/json',
	    		},
		);
	      _removeItem(index);
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(title),
            ),
          );
        },
      ),
    ),
    );
  }
}

class ParksListPage extends State<ParksList> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    var _userData = await Hive.openBox('UserData');
    final response = await http.get(Uri.parse('https://russ-travel.onrender.com/get-parks?user_id=${int.parse(_userData.getAt(0))}'),
    headers: {
    'Content-Type': 'application/json; charset=UTF-8', // Указываем кодировку UTF-8
    });
    
    if (response.statusCode == 200) {
      	//final decodedResponse
      	List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      	setState(() {
	        items = data.cast<Map<String, dynamic>>();
      	});
      	/*for (int i = 0; i < items.length; i++)
      	{
      		items[i] =       	
      	}*/
      	isLoading = false;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPageChanged(2);
        return false;
      },
      child: isLoading ? SpinKitChasingDots(color: Colors.blue, size: 50.0) : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context); // Действие по нажатию кнопки "Назад"
            widget.onPageChanged(2);
          },
        ),
        title: Text('Посещённые парки'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = items[index];
          String title = item['title'];

          return Dismissible(
            key: Key(title),
            onDismissed: (direction) async {
              var parkbox = await Hive.openBox('parkBox');
              var _userData = await Hive.openBox('UserData');
              int ind = -1;
              for (int i = 0; i < items.length; i++)
              {
              	print(items[i]['title'] + " " +  title);
              	if (items[i]['title'] == title)
              	{
              		ind = items[i]['id'];
              		break;
              	}
              }
              parkbox.delete(ind);
              final resp = await http.post(
		      Uri.parse('https://russ-travel.onrender.com/delete-park?id=${ind}&user_id=${int.parse(_userData.getAt(0))}'),
		      headers: {
	      			'accept': 'application/json',
	    		},
		);
	      _removeItem(index);
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(title),
            ),
          );
        },
      ),
    ),
    );
  }
}

class OutsListPage extends State<OutsList> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    var _userData = await Hive.openBox('UserData');
    final response = await http.get(Uri.parse('https://russ-travel.onrender.com/get-outs?user_id=${int.parse(_userData.getAt(0))}'),
    headers: {
    'Content-Type': 'application/json; charset=UTF-8', // Указываем кодировку UTF-8
    });
    
    if (response.statusCode == 200) {
      	//final decodedResponse
      	List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      	setState(() {
	        items = data.cast<Map<String, dynamic>>();
      	});
      	/*for (int i = 0; i < items.length; i++)
      	{
      		items[i] =       	
      	}*/
      	isLoading = false;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPageChanged(2);
        return false;
      },
      child: isLoading ? SpinKitChasingDots(color: Colors.blue, size: 50.0) : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context); // Действие по нажатию кнопки "Назад"
            widget.onPageChanged(2);
          },
        ),
        title: Text('Посещённые достопримечательности.'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = items[index];
          String title = item['title'];

          return Dismissible(
            key: Key(title),
            onDismissed: (direction) async {
              var outbox = await Hive.openBox('outsideBox');
              var _userData = await Hive.openBox('UserData');
              int ind = -1;
              for (int i = 0; i < items.length; i++)
              {
              	print(items[i]['title'] + " " +  title);
              	if (items[i]['title'] == title)
              	{
              		ind = items[i]['id'];
              		break;
              	}
              }
              outbox.delete(ind);
              final resp = await http.post(
		      Uri.parse('https://russ-travel.onrender.com/delete-out?id=${ind}&user_id=${int.parse(_userData.getAt(0))}'),
		      headers: {
	      			'accept': 'application/json',
	    		},
		);
	      _removeItem(index);
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(title),
            ),
          );
        },
      ),
    ),
    );
  }
}

class SignInPage extends State<SignIn>
{
	bool _isPasswordHidden = true;
	bool isLoading = false;
	
	String _email = '';
	String _password = '';
	String _textMessageRegistration = '';
	
	void _submitData() async {
	    setState( (){isLoading = true;} );
	    
	    final response = await http.post(
	      Uri.parse('https://russ-travel.onrender.com/sign-in'),
	      headers: {
      			'accept': 'application/json',
      			'Content-Type': 'application/x-www-form-urlencoded',
    		},
    	      body:	{
			      'grant_type': '',
			      'username': "${_email}",
			      'password': "${_password}",
			      'scope': '',
			      'client_id': '',
			      'client_secret': '',
			    },
	    );

	    if (response.statusCode == 200) {
	      // Обработка успешного ответа
	      print('Success: ${response.body}');
	      final lstStr = response.body.split(RegExp(r'[:{}, ]'));
	      print(lstStr[lstStr.indexOf("\"id\"") + 1] + " " + lstStr[lstStr.indexOf("\"name\"") + 1]);
	      var _userData = await Hive.openBox('UserData');
	      _userData.put('id', lstStr[lstStr.indexOf("\"id\"") + 1]);
	      _userData.put('name', lstStr[lstStr.indexOf("\"name\"") + 1].replaceAll('"', ''));
	      
	      var musBox = await Hive.openBox('museumBox');
	      var parkBox = await Hive.openBox('parkBox');
	      var outBox = await Hive.openBox('outsideBox');
	      musBox?.clear();
	      parkBox?.clear();
	      outBox?.clear();
	      
	      var res = await http.get(Uri.parse('https://russ-travel.onrender.com/get-museums?user_id=${int.parse(_userData.getAt(0))}'));
	      List<String> substrings = res.body.split(RegExp(r'[,: {}]+'));
	      for (int i = 0; i < substrings.length; i++) {
		if (substrings[i] == "\"id\"") {
			int number = int.parse(substrings[i + 1]);
			musBox.put(number, number);
		}
	      }
	      
	      res = await http.get(Uri.parse('http://russ-travel.onrender.com/get-parks?user_id=${int.parse(_userData.getAt(0))}'));
	      substrings.clear();
	      print("parks");
	      substrings = res.body.split(RegExp(r'[,: {}]+'));
	      for (int i = 0; i < substrings.length; i++) {
		if (substrings[i] == "\"id\"") {
			int number = int.parse(substrings[i + 1]);
			parkBox.put(number, number);
		}
	      }
	      
	      res = await http.get(Uri.parse('http://russ-travel.onrender.com/get-outs?user_id=${int.parse(_userData.getAt(0))}'));
	      substrings.clear();
	      print("outs");
	      substrings = res.body.split(RegExp(r'[,: {}]+'));
	      for (int i = 0; i < substrings.length; i++) {
		if (substrings[i] == "\"id\"") {
			int number = int.parse(substrings[i + 1]);
			outBox.put(number, number);		 
		}
	      }
	      
	      widget.onPageChanged(2);
	    } else {
	      // Обработка ошибки
	      setState( (){isLoading = false; _textMessageRegistration = 'Неправильный логин или пароль.';} );
	      print('${response.statusCode} - Error: ${response.reasonPhrase}');
	    }
	}
	
	Widget build(BuildContext context)
	{
		return Center
		(
			child:  
			Align
			(
				alignment: Alignment.center,
				child :  isLoading ? SpinKitChasingDots(color: Colors.blue, size: 50.0) : Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children:						
					[
						new Container(
  							width: 320,
  							height: 150,
  							child: Image.asset('assets/splash1.png'),
							),
						new Container
						(
							width : 350,
							child: new TextField(decoration: InputDecoration
									(
									enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Colors.black,
            								width : 1.0,
          								),
          							),
									focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Color.fromRGBO(0, 108, 167, 1),
            								width : 2.0,
          								),
          							),
									hintText : 'Введите ваш логин...',
									contentPadding: EdgeInsets.symmetric(horizontal: 20),
									),
									onChanged: (value) {
									    setState(() {
									      _email = value;
									    });
									  },
									cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								decoration: InputDecoration
								(
									enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Colors.black,
            								width : 1.0,
          								),
          							),
									focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Color.fromRGBO(0, 108, 167, 1),
            								width : 2.0,
          								),
          							),
									hintText : 'Введите ваш пароль...',
									contentPadding: EdgeInsets.symmetric(horizontal: 20),
									suffixIcon: IconButton(
                    					icon: Icon(
                        					_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    					onPressed: () {
                    						setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      					}),
								),
								onChanged: (value) {
								    setState(() {
								      _password = value;
								    });
								  },
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							height : 40,
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(255, 255, 255, 1),
									disabledForegroundColor: Colors.red,
									backgroundColor: Color.fromRGBO(0, 108, 167, 1), // фон кнопки
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { _submitData();},
								child: Text('Вход'),
								)
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(0, 108, 167, 1),
									disabledForegroundColor: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { widget.onPageChanged(1);},
								child: Text('Регистрация'),
								)
						),
						/*
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(0, 108, 167, 1),
									disabledForegroundColor: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
						*/
						new SizedBox(height: 8),
						Container(
						  width: 350,
						  child: Text(
						  style: TextStyle(
						    color: Colors.red,
						  ),
						  _textMessageRegistration)
						)
					]
				)
			)
		);
	}
}

class SignUpPage extends State<SignUp>
{
	bool _isPasswordHidden = true;
	bool _isRepeatPasswordHidden = true;
	bool isLoading = false;
	
	String _name = '';
	String _email = '';
	String _password = '';
	String _password2 = '';
	String _textMessageRegistration = '';
	
	static const String emailErrMsg =  "Неправильный адрес электронной почты.";
  	static const String passwordErrMsg = "Пароль должен содержать как минимум 6 символов.";
  	static const String confirmPasswordErrMsg = "Пароли не совпадают.";
	
	String? passwordVlidator(String? val) {
	    final String password = val as String;
	    if (password.isEmpty || password.length <= 5) return passwordErrMsg;
	    if (_password != _password2) return confirmPasswordErrMsg;
	    return null;
	}
	
	String? emailValidator(String? val) {
	    final String email = val as String;
	    if (email.length <= 3) return emailErrMsg;
	    final hasAtSymbol = email.contains('@');
	    final indexOfAt = email.indexOf('@');
	    final numbersOfAt = "@".allMatches(email).length;
	    if (!hasAtSymbol) return emailErrMsg;
	    if (numbersOfAt != 1) return emailErrMsg;
	    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;
	    return null;
	  }
	
	void _submitData() async {
	    setState(() {isLoading = true;});
	    
	    final email_temp = emailValidator(_email);
	    final pass_temp = passwordVlidator(_password);
	    if (email_temp != null)
	    {
	    	setState ((){isLoading = false; _textMessageRegistration = email_temp;});
	    	return;
	    }
	    else if (pass_temp != null)
	    {
	    	setState ((){isLoading = false; _textMessageRegistration = pass_temp;});
	    	return;
	    }
	    else
	    {
	    	setState ((){_textMessageRegistration = '';});
	    }
	
	    final response = await http.post(
	      Uri.parse('https://russ-travel.onrender.com/sign-up'),
	      headers: {
      			'accept': 'application/json',
      			'Content-Type': 'application/json',
    		},
    	      body: '{"email": "${_email}", "name": "${_name}", "password": "${_password}"}',
	    );

	    if (response.statusCode == 200) {
	      // Обработка успешного ответа
	      print('Success: ${response.body}');
	      final lstStr = response.body.split(RegExp(r'[:{}, ]'));
	      print(lstStr[lstStr.indexOf("\"id\"") + 1] + " " + lstStr[lstStr.indexOf("\"name\"") + 1]);
	      var _userData = await Hive.openBox('UserData');
	      //_userData.clear();
	      _userData.put('id', lstStr[lstStr.indexOf("\"id\"") + 1]);
	      _userData.put('name', lstStr[lstStr.indexOf("\"name\"") + 1].replaceAll('"', ''));
	      widget.onPageChanged(2);
	    } else {
	      setState (() {isLoading = false; _textMessageRegistration = 'Ошибка подключения к серверу!';});
	      // Обработка ошибки
	      print('${response.statusCode} - Error: ${response.reasonPhrase}');
	    }
	}

	Widget build(BuildContext context) {
		return new Center
		(
			child: new Align
			(
				alignment: Alignment.center,
				child : isLoading ? SpinKitChasingDots(color: Colors.blue, size: 50.0) : Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children:
					[
						new Container(
  							width: 320,
  							height: 150,
  							child: Image.asset('assets/splash1.png'),
							),
						new Container
						(
							width : 350,
							child: new TextField(decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Введите ваше имя...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),),
								onChanged: (value) {
								    setState(() {
								      _name = value;
								    });
								  },
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Введите ваш email...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),),
								onChanged: (value) {
								    setState(() {
								      _email = value;
								    });
								  },
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Придумайте пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      				}),
								),
								onChanged: (value) {
								    setState(() {
								      _password = value;
								    });
								  },
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isRepeatPasswordHidden,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Повторите ваш пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isRepeatPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isRepeatPasswordHidden = !_isRepeatPasswordHidden; });
                      				}),
								),
								onChanged: (value) {
								    setState(() {
								      _password2 = value;
								    });
								  },
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350,
							height : 40,
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(255, 255, 255, 1),
									disabledForegroundColor: Colors.red,
									backgroundColor: Color.fromRGBO(0, 108, 167, 1), // фон кнопки
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {_submitData();},
								child: Text('Регистрация'),
								)
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(0, 108, 167, 1),
									disabledForegroundColor: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { widget.onPageChanged(0); },
								child: Text('Авторизация'),
								)
						),
						/*
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									foregroundColor: Color.fromRGBO(0, 108, 167, 1),
									disabledForegroundColor: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
						*/
						new SizedBox(height: 8),
						Container(
						  width: 350,
						  child: Text(
						  style: TextStyle(
						    color: Colors.red,
						  ),
						  _textMessageRegistration)
						) 
					]
				)
			)
		);
	}
}

class AccountPage extends State<Account>
{
	Future<void> clearDatabases() async {
		var userData = await Hive.openBox('UserData');
		var resp = await http.post(
			Uri.parse('https://russ-travel.onrender.com/clear-museums?user_id=${int.parse(userData.getAt(0))}'),
			headers: {
				'accept': 'application/json',
			},
		);
		if (resp.statusCode == 200)
		{
			var musBox = await Hive.openBox('museumBox');
			musBox?.clear();
		}
		
		resp = await http.post(
			Uri.parse('https://russ-travel.onrender.com/clear-parks?user_id=${int.parse(userData.getAt(0))}'),
			headers: {
				'accept': 'application/json',
			},
		);
		if (resp.statusCode == 200)
		{
			var parkBox = await Hive.openBox('parkBox');
			parkBox?.clear();
		}
		
		resp = await http.post(
			Uri.parse('https://russ-travel.onrender.com/clear-out?user_id=${int.parse(userData.getAt(0))}'),
			headers: {
				'accept': 'application/json',
			},
		);
		if (resp.statusCode == 200)
		{
			var outBox = await Hive.openBox('outsideBox');
			outBox?.clear();
		}
	}
	
	Future<void> clearBoxes() async {
		var musBox = await Hive.openBox('museumBox');
		musBox?.clear();
		var parkBox = await Hive.openBox('parkBox');
		parkBox?.clear();
		var outBox = await Hive.openBox('outsideBox');
		outBox?.clear();
	}
	
	Widget build(BuildContext context) {
	    return FutureBuilder(
	    future: Hive.openBox('UserData'),
	    builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
	      if (snapshot.connectionState == ConnectionState.done) {
		if (snapshot.hasData) {
		  final userData = snapshot.data;
		  int id = int.parse(userData?.get('id'));
		  String name = userData?.get('name');
		  return MaterialApp(
		    home: Scaffold(
		      appBar: AppBar(
		        title: Text(name ?? 'Loading...'),
		      ),
		      body: ListView(
		        children: <Widget>[
		          ListTile(
		            title: Text('Музеи'),
		            onTap: () {
		              setState(() { widget.onPageChanged(3);});
		            },
		          ),
		          ListTile(
		            title: Text('Парки'),
		            onTap: () {
		              setState(() { widget.onPageChanged(4);});
		            },
		          ),
		          ListTile(
		            title: Text('Внешние объекты'),
		            onTap: () {
		              setState(() { widget.onPageChanged(5);});
		            },
		          ),
		          ListTile(
		            title: Text('Очистить все данные...'),
		            onTap: () {
		              clearDatabases().then((_) {
		                // Логика, если нужно что-то сделать после очистки
		              });
		            },
		          ),
		          ListTile(
		            title: Text('Выйти...'),
		            onTap: () {
	      		      userData?.clear();
	      		      clearBoxes().then((_) {
		                // Логика, если нужно что-то сделать после очистки
		              });
		              widget.onPageChanged(0);
		            },
		          ),
		        ],
		      ),
		    ),
		  );
		}
	      }
	      return CircularProgressIndicator(); // Show loading indicator
	    },
	  );
	}
}

class ProfilePage extends State<Profile>
{
	int _currentIndex = 2;
	void changePage(int page) {
    	setState(() {
      		_currentIndex = page;
    	});
  	}
	
	/*
	Widget build(BuildContext context) {
		var _userData = await Hive.openBox('UserData');
		if (_userData.containsKey('id'))
		{
			print("UNFOUND");
			_currentIndex = 0;
		}
		else
		{
			print("ABSOLUTELY FOUND");
	      		_currentIndex = 2;
	      	}
		final List<Widget> _pages = [
		    	SignIn(changePage),
		    	SignUp(changePage),
		    	Account(changePage),
		];	
		return _pages[_currentIndex];
	}
	*/
	
	Widget build(BuildContext context) {
	    return FutureBuilder(
		future: Hive.openBox('UserData'),
		builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
		    if (snapshot.connectionState == ConnectionState.done) {
		    	//print(snapshot?.data?.values.toList());
		        if (snapshot?.data?.values.toList().isEmpty ?? false) {
		            print("UNFOUND");
		            if (_currentIndex == 2)
		            	_currentIndex = 0;
		        } else {
		            print("ABSOLUTELY FOUND");
		            if (_currentIndex == 0 || _currentIndex == 1)
		            	_currentIndex = 2;
		        }
		        final List<Widget> _pages = [
		            SignIn(changePage),
		            SignUp(changePage),
		            Account(changePage),
		            MuseumsList(changePage),
		            ParksList(changePage),
		            OutsList(changePage),
		        ];    
		        return _pages[_currentIndex];
		    } else {
		        return CircularProgressIndicator();
		    }
		},
	    );
	}
}
