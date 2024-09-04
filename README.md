This is a sample task manager app meant to sync data offline and online

to run  this app successfully ,

kindly run the following commands

1. Activate FlutterFire CLI:
    dart pub global activate flutterfire_cli

2. Run the FlutterFire configuration command:
    flutterfire configure

3 Run localization command
    flutter gen-l10n

4. there is a makefile  with make commands in the repo to help run the app

make run  to run the app
make appbundle to release appbundle
make build-apk to release an apk

please note that i commented out gitignore to allow the keyfiles to be uploaded for test purposes