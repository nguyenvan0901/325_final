Folder: Model 
- barcode_scanner.dart: handle the logic behind opening the camera, reading the barcode from the photo and using that barcode to get the food info.

- firebase.dart: handle the logic behind writing new data into firebase and reading data from firebase.

Folder: View:
- add_item.dart: the first screen that users will see when navigating to the add function, this screen contains a list of food suggestions and a button for users to open up the barcode scanner.

- details.dart: this screen displays the information of the food in detail.

- home.dart: this screens contains the navigation bar

- loading.dart: this screen contains the loading widget indicating to users that the app is processing the barcode.

- record.dart: this screen shows a list of added food (read from the database).

- settings.dart: this screen allows users to change the screen setting (dark/bright mode) and also allows users to change the meta data (calories goal, carb, protein, fat goals).

- summary.dart: this screen show visualisation of the amount of calories, carbs, protein and fat users have consumed today.

- main.dart: contains the welcome page.

Folder Controller:
- Contains all the navigation logic behind each working features. 