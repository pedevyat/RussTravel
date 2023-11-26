import 'package:flutter/material.dart';

int currentIndex = 1;

class Profile extends StatefulWidget{
  ProfilePage createState()=> ProfilePage();
}

class SignIn extends StatefulWidget{
  SignInPage createState()=> SignInPage();
}

class SignUp extends StatefulWidget{
  SignUpPage createState()=> SignUpPage();
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
							child: new TextField(decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Введите ваш логин...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),)
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Введите ваш пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      				}),
								),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(255, 255, 255, 1),
									onSurface: Colors.red,
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
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { setState() { if (currentIndex > 1) currentIndex = 0; else currentIndex += 1; }},
								child: Text('Регистрация'),
								)
						),
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
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
							child: new TextField(decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Введите ваш логин...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),)
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Введите ваш email...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),)
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Придумайте пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      				}),
								),
							),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isRepeatPasswordHidden,
								decoration: InputDecoration(border: OutlineInputBorder(),
								hintText : 'Повторите ваш пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isRepeatPasswordHidden = !_isRepeatPasswordHidden; });
                      				}),
								),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(255, 255, 255, 1),
									onSurface: Colors.red,
									backgroundColor: Color.fromRGBO(0, 108, 167, 1), // фон кнопки
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
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
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { setState() { if (currentIndex > 1) currentIndex = 0; else currentIndex += 1;}},
								child: Text('Авторизация'),
								)
						),
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
					]
				)
			)
		);
	}
}

class ProfilePage extends State<Profile>
{
	final List<Widget> _pages = [
    	SignIn(),
    	SignUp(),
	];
	
	Widget build(BuildContext context) {
		return _pages[currentIndex];
	}
}
