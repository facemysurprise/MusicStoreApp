import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/presentation/screens/User_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


class MockAuthBloc extends Mock implements AuthBloc {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  group('UserPage Tests', () {
    late MockAuthBloc mockAuthBloc;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      mockNavigatorObserver = MockNavigatorObserver();

    
      SharedPreferences.setMockInitialValues({
        'name': 'John Doe',
        'phone': '1234567890',
        'country': 'Some Country',
        'photoUrl': '',
        'stories': ['story1.jpg', 'story2.jpg']
      });
    });

    testWidgets('should display user information and stories correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: UserPage(),
          ),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      await tester.pumpAndSettle(); 

      
      expect(find.text('Имя Фамилия'), findsOneWidget);
      expect(find.text('87770001122'), findsOneWidget);
      expect(find.text('Страна'), findsOneWidget);

      
      expect(find.byType(StoriesBar), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNWidgets(3)); 
    });

 testWidgets('should allow adding a new story', (WidgetTester tester) async {
    final mockImagePicker = MockImagePicker();

   
    when(mockImagePicker.pickImage(source: ImageSource.gallery))
        .thenAnswer((_) async => XFile('path/to/new/story.jpg'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: UserPage(),
          ),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      await tester.pumpAndSettle(); 

    
      await tester.tap(find.byType(CircleAvatar).first);
      await tester.pumpAndSettle();

      
      final updatedStories = SharedPreferences.getInstance().then((prefs) => prefs.getStringList('stories') ?? []);
      expect(updatedStories, contains('path/to/new/story.jpg'));
    });

    

  });
}