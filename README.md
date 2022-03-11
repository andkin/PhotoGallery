
# PhotoGallery

## Project structure

```
├── PhotoGallery
│   ├── Application - AppDelegate, bundle files
│   ├── Extensions
│   ├── Library - reusable, shared stuff
│   ├── Models - domain models
│   ├── Resources
│   ├── Services - different kinds of managers, e.g. networking, routers, etc.
│   └── UserStories - view controllers, view models, views, cells, etc..
└───
```
## Architecture
App uses custom MVVM architecture pattern. The picture below describes the original MVVM: 
![iOS MVVM](https://www.objc.io/images/issue-13/mvvm1-16d81619.png) <br>
However, in the current implementation **ViewModel** doesn't use KVO, instead, a controller updates its model by calling appropriate methods and receives responses via **delegate** pattern.

Update **ViewModel**:

    func textViewDidChange(_ textView: UITextView) {
        viewModel.descriptionText = textView.text.trimmed
    }

Receive update:
```
extension MainViewController: MainViewModelDelegate {
  func didLoadData() {
    dismissAndPresentDetails()
  }
}
```


## Build and Run
Xcode 13.2.1 and higher <br>
Swift 5.5.2 and higher <br>
Cocoapods 1.11.2 and higher

