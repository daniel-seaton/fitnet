# fitnet

A new workout tracking application designed to be more customizable and modular than any before

## Folder Structure

Folders are organized in a nested structure based on which widgets are nested inside others, and are named after the widget. So if you have custom widget A that has custom widget B and C inside it, then you should have folder `A` with file `A.dart`, and two subdirectories `B` and `C` with `B.dart` and `C.dart`, respectively.

This folder structure is then duplicated in the test folder, with `A_test.dart` in folder `test/A`, and `B_test.dart` and `C_test.dart` in `test/A/B` & `test/A/C`, respectively.

Services have their own folder: `lib/services`. As of right now, there are few services, so all of them may go at the root of that directory. This may change as the code base grows.

As of right now, there are no shared components, but when/if there is, they should go in `src/shared/`

## Injector Model

This codebase uses a package called `GetIt` in order to inject services across components. This means that rather than creating a new instance of each service when its needed within a file, you can instead do as follows:
```
    final Service service = injector<Service>();
```
New services that are added should be declared in `lib/serviceInjector.dart` following the existing pattern. It is important to note that if any service is dependent on another, then the dependent service must be declared AFTER the other.

This both saves memory and allows us to easily mock services and use those during testing -- See the testing section below for details.

## Testing

Test files are named after the component their testing, with `_test` at the end. Ex/ Tests for `A.dart` are in `A_test.dart`

Each test file has two main groups named `Unit Tests` and `Component Tests`. There is a template for tests that can be found in `test/template.dart`

Unit tests are for testing any functions within the file, and should follow normal unit testing best practices. They should not call any services or use any real data, but instead use the mock functions located in `test/mocks.dart`. Within the unit test group, tests should be grouped based on which function they're testing.

Component tests are for testing what is being displayed on the screen, and that things function as expected. 
Things that DO NOT need to be component tested:
 * styling
 * hard-coded text
 * outcome of button clicks (ie/ you do not need to test that clicking `Delete` removes something from the database)
Things that DO need to be component tested:
 * custom widgets being displayed
 * buttons clicks calling the expected functions (ie/ you do need to test that clicking `Delete` calls the function that WOULD remove something from the database)
 * any user inputs work as expect (things that should be clickable/swipable, are)

 ### Mocks

 Services are mocked using `mockito`. Whenever a new service is declared, a mock version of that service should also be declared in `test/mocks.dart` with the following naming convension:
 ```
    class ServiceMock extends Mock implements Service {};
 ```
 The service mock should then be added to `test/testServiceInjector.dart`. This will allow us to use the same injector model described above in our tests in order to fetch the mock services and use them.


 ### Initial Setup
 
 In order to get the aws cognito integration to work, you need to create two files, both called `awsconfiguration.json`. These files are not commited because they contain sensitive data, and so I didn't want to put them on a public repository.

 Both files are the same. The first should be created in `android/app/src/main/res/raw` and should look like this:
 ```
{
    "IdentityManager": {
        "Default": {}
    },
    "CognitoUserPool": {
        "Default": {
            "PoolId": "##-####-#_#########",
            "AppClientId": "#########################",
            "AppClientSecret": "####################################################",
            "Region": "##-####-#"
        }
    }
}
```

To create the second file, you need to open `ios/Runner.xcworkspace` in xcode, and the add the file to the `Runner/Runner` folder (next to `AppDelegate.swift`)
====================================================================
## TODO

### 1.0:
 * implement graphing of workout data
 * edit workout screen styling
 * ability to change steps during the workout (change instances to use two lists of completed/pending steps?)
 * add circuit workout step type
 * add dark mode
 * add user settings
 * add backend pagination on list requests (and filter by uid from the jwt for workout instances)
 * add more/better validations on backend
 * add ability to update weight
 * add tests (opt)
 * fix bug with set based screen where in progress step isn't turning blue unless you change the weight
 * change all notifiers to be named _____State insteadof change notifier
 * change services to only be accessible through the associated entity (exception: auth service)
 * figure out how to use environment variables for different environments: maybe https://binary-studio.com/2020/04/17/flutter-2/ ?
### 2.0
 * Implement 'gyms' feature and other social aspects (paid by number of people in the gym?)
 * Allow users to publish workouts(paid feature?)
 * Allow users to search for published workouts and do them (paid feature?)
 * Allow meal tracking
