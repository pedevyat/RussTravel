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

class SignInPage extends State<SignIn>
{
	bool _isPasswordHidden = true;
	
	String _email = '';
	String _password = '';
	
	void _submitData() async {
	    http.get(Uri.parse('https://russ-travel.onrender.com/')).then((response) {
	    print("Response status: ${response.statusCode}");
	    print("Response body: ${response.body}");
	    }).catchError((error){
	        print("Error: $error");
	    });
	    
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
	      print('${response.statusCode} - Error: ${response.reasonPhrase}');
	    }
	}
	
	Widget build(BuildContext context)
	{
		return new Center
		(
			child: new Align
			(
				alignment: Alignment.center,
				child : new Column
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
								onPressed: () {_submitData();},
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
	
	String _name = '';
	String _email = '';
	String _password = '';
	String _textMessageRegistration = '';
	
	static const String emailErrMsg =  "Invalid Email Address, Please provide a valid email.";
  	static const String passwordErrMsg = "Password must have at least 6 characters.";
  	static const String confirmPasswordErrMsg = "Two passwords don't match.";
	
	String? passwordVlidator(String? val) {
	    final String password = val as String;
	    if (password.isEmpty || password.length <= 5) return passwordErrMsg;
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
	    http.get(Uri.parse('https://russ-travel.onrender.com/')).then((response) {
	    print("Response status: ${response.statusCode}");
	    print("Response body: ${response.body}");
	    }).catchError((error){
	        print("Error: $error");
	    });
	    
	    final email_temp = emailValidator(_email);
	    final pass_temp = passwordVlidator(_password);
	    if (email_temp != null)
	    {
	    	_textMessageRegistration = email_temp;
	    	return;
	    }
	    else if (pass_temp != null)
	    {
	    	_textMessageRegistration = pass_temp;
	    	return;
	    }
	    else
	    {
		_textMessageRegistration = '';	    
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
				child : new Column
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
		              // Действие при нажатии на кнопку 'Музеи'
		            },
		          ),
		          ListTile(
		            title: Text('Парки'),
		            onTap: () {
		              // Действие при нажатии на кнопку 'Парки'
		            },
		          ),
		          ListTile(
		            title: Text('Внешние объекты'),
		            onTap: () {
		              // Действие при нажатии на кнопку 'Внешки'
		            },
		          ),
		          ListTile(
		            title: Text('Отели'),
		            onTap: () {
		              // Действие при нажатии на кнопку 'Отели'
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
		            _currentIndex = 2;
		        }
		        final List<Widget> _pages = [
		            SignIn(changePage),
		            SignUp(changePage),
		            Account(changePage),
		        ];    
		        return _pages[_currentIndex];
		    } else {
		        return CircularProgressIndicator();
		    }
		},
	    );
	}
}
