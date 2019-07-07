# MotoLive

## Architecture:
1. API calls are handled by `APIClient` class, views communicate to the network using the `LessonManager` class.
2. `LessonManager`  is the data manager for the app, it communicates with the API and the DB to provide data to the views.
3. `LessonsViewController` renders data to the view and interact with user's action.

## Database:
The database is using [Realm](https://realm.io/docs/swift/latest/) to persist data. For simplicity sake all DB operations are made on the main thread this is because the app only makes one very small API call. A more heavy duty networking will require moving DB handling to a background thread.

### [Models](MotoLive/Models)
1. `Lesson` is used to store lesson data coming from the server.
2. `LessonProgress` is used to store user's lesson progress as they use the app.

## Features:
1. App UI is incompatible with iPad view or iPhone landscape. 
2. App load video playlist on launch or if the user pulls to refresh.
3. Each video can open in full screen and support landscape mode.
4. App track user's video progress and display it on `LessonsViewController`.
5. The app differentiates between videos that the user already finished watching to those never watch or partially watch. 
