
![Logo](http://kaloyanek.me/assets/img/logo_brandname_white.svg)
![Logo](http://kaloyanek.me/assets/img/logo_brandname_black.svg)


# iDentity - Social Network

iDentity is an social network which is so similar to Instagram.


## Documentation

[Documentation](https://docs.google.com/document/d/1Qm59rYWPPlsGUJcZ-TADt4noKzNUSVjpFRgp_YWR8qo/edit?usp=sharing)


## Tech Stack


![Logo](https://github.com/flutter/website/blob/archived-master/src/_assets/image/flutter-lockup-bg.jpg?raw=true)


![Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Firebase_Logo.svg/1200px-Firebase_Logo.svg.png)


## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`FIREBASE_API_KEY`

`FIREBASE_APP_ID`

`FIREBASE_MESSAGING_SENDER_ID`

`FIREBASE_PROJECT_ID`

`FIREBASE_STORAGE_BUCKET`
## Run Locally

Clone the project

```bash
  git clone https://github.com/KaloGH/identity-project.git
```

Go to the project directory

```bash
  cd identity-project
```

Install dependencies

```bash
  flutter pub get
```



## Run i Local

To run this project in chrome run

```bash
  $> flutter run -d chrome
```

To run this project in mobile device

```bash
  $> flutter devices
        sdk gphone x86 (mobile) • emulator-5554 • android-x86    • Android 11 (API 30) (emulator)
        Windows (desktop)       • windows       • windows-x64    • Microsoft Windows [VersiÃ³n 10.0.19044.1706]
        Chrome (web)            • chrome        • web-javascript • Google Chrome 101.0.4951.67
        Edge (web)              • edge          • web-javascript • Microsoft Edge 101.0.1210.53
  
  $> flutter run -d emulator-5554
```

## Used Dependencies
[firebase_core](https://pub.dev/packages/firebase_core) -> Needed to use Firebase

[cloud_firestore](https://pub.dev/packages/cloud_firestore) -> Is our database

[firebase_auth](https://pub.dev/packages/firebase_auth) -> Used to authenticate users, login and signup

[firebase_storage](https://pub.dev/packages/firebase_storage) -> Used to store all uploaded images

[flutter_svg](https://pub.dev/packages/flutter_svg) -> Used to show SVG

[intl](https://pub.dev/packages/intl) -> Used to format Date more easy.

[file_picker](https://pub.dev/packages/file_picker) -> Used for pick the files.

[flutter_staggered_grid_view (0.4.1)](https://pub.dev/packages/flutter_staggered_grid_view) -> Used in SearchScreen to make random grid

[provider](https://pub.dev/packages/provider) -> Used to make easier the use of the User Provider and more reusable.

