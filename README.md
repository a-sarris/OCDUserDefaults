# OCDUserDefaults
 A small Swift Package that is wrapper around UserDefaults that allows the clients to use an `enum` as key.
 The wrapper exposes a cleanup function that removes unused keys, providing a sort of self cleaning functionality as the `enum` values change as the app evolves.

# Usage

### Create an enum with String as a raw value
 ```
 enum Key: String {
        case tutorialShown
        case notificationShown
    }
 ```
### Somewhere at the start of your app's lifecycle call:
```
defaults.cleanup(Key.self)
```
 ### Set a value using one of the provided wrappers
 ```
 defaults.set(true, forKey: Key.tutorialShown)
 defaults.set(true, forKey: Key.notificationShown)
 ```

If `case notificationShown` is removed, then the next time `defaults.cleanup(Key.self)` runs, the value will be removed from UserDefaults.

 

