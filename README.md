# LastFM app

A Flutter app that displays tracks from http://last.fm/

## Getting Started

1. Create the API key at https://www.last.fm/api/account/create

2. At the top-level directory of the project create a `.env` file with the following content:
```
API_KEY=Your API key
```

3. Install packages by running:
```sh
flutter pub get
```

4. Run the generator with the following command:
```sh
flutter pub run build_runner build
```

## Screenshots
![LastFM App](/screenshots/last-fm.gif "LastFM app")

## Built with:
* [Flutter](https://flutter.dev/) - Flutter makes it easy and fast to build beautiful mobile apps.
* [Riverpod](https://pub.dev/packages/riverpod) - A simple way to access state from anywhere in your application while robust and testable.
* [Auto Route](https://pub.dev/packages/auto_route) - AutoRoute is a declarative routing solution, where everything needed for navigation is automatically generated for you.
* [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv) - Easily configure any flutter application with global variables using a `.env` file.
* [Flutter Hooks](https://pub.dev/packages/flutter_dotenv) - A flutter implementation of React hooks. It adds a new kind of widget with enhanced code reuse.
