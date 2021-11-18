# ddd_architecture_flutter

A Flutter project consisting of making a note-making app through the implementation of Domain Driven Design Architecture.

## Getting Started

By the end of this project, we'll be have an application in which user can login, logout, save notes and add some TODOs in the notes. We'll be using Firebase Auth for authentication and Firebase Firestore for storing user data. Hence, once you clone this project kindly download your own `google-services.json` file one you make your own Firebase project. Make sure to have the same package name provided to Firebase project as applicationID mentioned in `android/app/build.gradle`.

Now, explaining the architecture...

We divide our app into 4 different layers : Presentation, Application, Domain, Infrastructure.

Presentation Layer : Most of the widgets and UI code is written here.

Application Layer : BLoCs/Any other handling method. No UI code. No network, no database code. The only work of this layer is to take events from Presentation layer and output what to do next. Basically orchestrate the flow of data around the application.

Domain : Most necessary and censored layer of any app. It contains all the business logic and stuff as well as ENTITIES and VALIDATED VALUE OBJECTS (which hold logics) and FAILURES.
Validated value objects are kind of business rules. Ex : if we take email as an input from the user then whether that e-mail is valid or invalid we validate it via 'Validated Value Objects'.
In the real world app, we don't validate the values in the Presentation layer. We do it in domain layer and integrate it with the main flow of the application.
Entities are kind of 'what a user does in the application?' part. Hence, it contains Validated Value Objects.
Failures are the exceptions that has arised in the flow of the app and integrating them into the flow of the application and doesn't creating a different stream for them so that the code becomes a mess.
DOMAIN LAYER DOESN'T DEPEND ON ANY OTHER LAYER. On the other hand, other layers depend on domain layers.

Core Folder (in domain) holds all the boilerplate code that can be reused with minor change in different parts of application (in our case, for email and password validation).

Infrastructure : It interacts with APIs, databases and device sensors (if any). We have to design it in such a way that if we want to change the database say from sqlite to no sql database, we won't need tochange anything outside from this layer. It has 3 parts : REPOSITORIES, DATA TRANSFER OBJECTS and DATA SOURCES.
Repositories play an important part of being the boundary b/w the boundary and application layer and outside world. Hence, all exception will be handled in the Repositories and the data will be sent accordingly to the domain layer entities. Also, if you don't use Firebase Firestore (which handles caching of data as well) then the caching logic also comesin Respositories.
The sole purpose of Data Transfer Objects is to convert data b/w entities and value objects from Domain layer and plain data coming from API/Database/source.
