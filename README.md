# feel

Tracker for health condition. Shows reports & statistics based on collected data.

## Compile & Deploy
### On Linux
```
flutter clean
flutter build linux
flutter run # for debug
```

### On Android
```
flutter clean
flutter build android
flutter devices
flutter run -d <device> # for debug
flutter install -d <device> # for installation
```

### On iOS
```
flutter clean
flutter build ios
flutter devices
flutter run -d <device> # for debug
flutter install -d <device> # for installation OR do it via Xcode
```

## Update app icon
Update file in `assets/icon/icon.png` and run `flutter pub run flutter_launcher_icons:main`.

## Update iOS launcher screen
Open Xcode and modify LaunchScreen.storyboard.

## TODOs
* [ ] Add option to edit data sets
* [ ] Add option to export / import data sets
* [x] Add statistics
* [x] Add "Home" tab/view with fancy-shrancy card-based reports
* [x] Fix reset of FilterChips in AddDataSetWidget (does not work rn)
* [x] Add pagination to data table