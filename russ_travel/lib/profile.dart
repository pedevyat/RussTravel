import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
								onPressed: () {},
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
	    http.get(Uri.parse('http://127.0.0.1:8000/')).then((response) {
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
	      Uri.parse('http://127.0.0.1:8000/sign-up'),
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
	      print(lstStr[lstStr.indexOf("\"id\"") + 1] + lstStr[lstStr.indexOf("\"name\"") + 1]);
	      //var _userData = Hive.box('UserData');
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
	Widget build(BuildContext context) {
		return MaterialApp(
		      home: Scaffold(
			appBar: AppBar(
			  title: Text('NAME'),
			),
			body: ListView(
			  children: <Widget>[
			    ListTile(
			      title: Text('Музеи'),
			      onTap: () {
				// Действие при нажатии на кнопку 'Отели'
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
			      title: Text('Выйти...'),
			      onTap: () {
				// Действие при нажатии на кнопку 'Выйти...'
			      },
			    ),
			  ],
			),
		      ),
		    );
	}
}

class ProfilePage extends State<Profile>
{
	int _currentIndex = 1;
	
	void changePage(int page) {
    	setState(() {
      		_currentIndex = page;
    	});
  	}
	
	Widget build(BuildContext context) {
		final List<Widget> _pages = [
		    	SignIn(changePage),
		    	SignUp(changePage),
		    	Account(changePage),
		];	
		return _pages[_currentIndex];
	}
}
