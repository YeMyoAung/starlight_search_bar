<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# starlight_search_bar

If you find the easiest way to search your item, this is for you.

## Features

You can find your item in the easiest way.

## ScreenShots 

<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/151706715-2bb44714-f0ed-4b69-bc00-6c5bb5fed5e7.png" width="200px">
</a>&nbsp;&nbsp;
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/151706710-ff3f7762-5c6f-4823-9b51-72f55ded1963.png" width="200px">
</a>&nbsp;&nbsp;

## Installation

Add starlight_search_bar as dependency to your pubspec file.

```dart
starlight_search_bar: 
    git:
      url: https://github.com/YeMyoAung/starlight_search_bar.git
```

## Usage

First of all you need to import our package.

```dart
import 'package:starlight_search_bar/starlight_search_bar.dart';
```

## Parameters and Uses

```
    ///if you want to see query data,you need to set true
    bool debugQuery = false,

    ///BuildContext is required
    required BuildContext context,

    ///Search Data is required
    required List<T> data,

    ///If you provide a list of map, you will need to provide the key of map
    List<String>? targets,

    ///if you want to show custom suggestion ,you can provide a widget
    Widget Function(T)? buildSuggestion,

    ///if you want to show custom result ,you can provide a widget
    Widget Function(T)? buildResult,

    ///if you want to do something after on tap at suggestion,you can provide a function with a parameter
    Function(T)? onSuggestionTap,

    ///if you want to do something after on tap at result,you can provide a function with a parameter
    Function(T)? onResultTap,

    ///if you want to set custom search,you can provide a function with two parameter
    List<T> Function(List<T>, String)? onSearch,

    ///if you want to show custom leading ,you can provide a widget
    Widget? leading,

    ///if you want to show custom action ,you can provide a list of widget
    List<Widget>? action,

    ///if you want to show custom search field label ,you can provide a string
    String? searchFieldLabel,

    ///if you want to show custom search field label ,you can provide a text style
    TextStyle? searchFieldStyle,

    ///if you want to show custom search field label ,you can provide an input decoration theme
    InputDecorationTheme? searchFieldDecorationTheme,

    ///if you want to show custom keyboard type ,you can provide a keyboard type
    TextInputType? keyboardType,

    ///if you want to work with custom action ,you can provide an input action
    TextInputAction textInputAction = TextInputAction.search,
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:starlight_search_bar/starlight_search_bar.dart';
import 'package:starlight_utils/starlight_utils.dart';
import 'package:test_application/state/state.dart';

String _transform(String name) {
  try {
    return "${double.parse(name).currencyFormat} Ks";
  } catch (e) {
    return name.toValidate;
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StarlightUtils.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Starlight Search Bar"),
        actions: [
          IconButton(
            onPressed: () {
              StarlightSearchBar.searchBar<Map>(
                context: context,
                data: [
                  {
                    "name": "Mg Mg",
                    "age": 15,
                  },
                  {
                    "name": "Aung Aungg",
                    "age": 12,
                  },
                  {
                    "name": "Su Su",
                    "age": 25,
                  },
                  {
                    "name": "Mya Mya",
                    "age": 18,
                  },
                  {
                    "name": "Hla Hla",
                    "age": 20,
                  },
                ],
                targets: ['name', 'age'],
                debugQuery: false,
                // buildResult: (value) => Text(value['name']),
                // buildSuggestion: (value) => Text(value['name']),
                onResultTap: (e) {
                  print(e);
                },
                onSuggestionTap: (e) {
                  print(e);
                },
                // onSearch: (data, string) => data
                //     .where((element) => element['name'].contains(string))
                //     .toList(),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            StateListener(
              transform: _transform,
            ),
            TextField(
              onChanged: StateChange.onChange,
            ),
          ],
        ),
      ),
    );
  }
}

```

## Contact Us

[Starlight Studio](https://www.facebook.com/starlightstudio.of/)

