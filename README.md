![Weact](banner.png)

# Weact (Swift + React)
[![Language: Swift 3](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 9+](https://img.shields.io/badge/platform-iOS%209%2B-blue.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/freshOS/then/blob/master/LICENSE)
![Release version](https://img.shields.io/badge/release-0.1-blue.svg)

Weact is a Swift framework for building component-oriented interfaces.  
Because it's unfair to need javascript to enjoy Components ! 😎

![Demo](demo.gif)
*<p align="center">Building a Loading screen with Hot reload 🎩</p>*

```swift
func render() -> Node {
    return Label("Hello, Component !")
}
```

New to components? Fear not! [Facebook's React guide](https://facebook.github.io/react/) is a gold mine of information to get you started :)


|      | Weact                                   |
| ---- | ---------------------------------------- |
|  🔶  | Pure **Swift** (no JS, no XML)           |
|  🏗    | Can be used **Incrementally** in your classic UIKit App |
|   📐  |Can use **Autolayout or any autolayout** lib for the layout (we like [Stevia](https://github.com/freshOS/Stevia)) |
| 💉 | Supports **Hot Reload** with [💉 injectionForXcode](http://johnholdsworth.com/injection.html)|

## A Bare Component

A component is pretty simple :
- It has a `render` function that returns a `Node`.
- It has a `state` property.

That's All!

```swift
import Weact

class MyFirstComponent: Component {

    var state = MyState()

    func render() -> Node {
        return Label("Hello!")
    }
}
```

## View Controller Component
To use a component as a `UIViewController` and play nicely with UIKit apis, just subclass
`UIViewController` and call  `loadComponent` in `loadView` :)

```swift
class LoadingScreen: UIViewController, Component {

    // Just call `loadComponent` in loadView :)
    override func loadView() { loadComponent() }

    func render() -> Node {
        return ...
    }
}

```
You can now `push` and `present` your view controller like you used to, except this is now a powerful component! 😎

## View Component
This is particularly handy to start migrating parts of the App to using components without breaking everything!
To use a component as a `UIView` and play nicely with UIKit apis, just subclass
`UIView` and call  `loadComponent` in an `init` function :)
```swift
class MyCoolButton: UIView, Component {

    // Here we load the component
    convenience init() {
        self.init(frame:CGRect.zero)
        loadComponent()
    }

    func render() -> Node {
        return ...
    }
}
```
This way you have classic `UIView` that behaves like a component! 💪

## Nodes

The idea is that you will compose your own components out of the default nodes provided.

The naming is pretty simple, take the UIKit name and remove `UI` prefix.
`UIView` becomes `View`, `UIButton` `Button`, etc... you get it :)

Here is the complete list of provided nodes :  
`View`  
`Label`  
`Field`(TextField)  
`Button`  
`Image`  
`ScrollView`  
`PageControl`  
`ActivityIndicatorView`   
`VerticalStack`  
`HorizontalStack`

### Left to implement (coming soon)
SegmentedControl
Slider
Switch
ProgressView
Stepper
TableView
CollectionView
TableViewCell
CollectionViewCell
TextView
DatePicker
PickerView
VisualEffectView
MapKitView
Webview
TapGestureRecognizer
PinchGestureRecognizers
RotationGestureRecognizers
SwipeGestureRecognizers
Toolbar
SearchBar

### Customizing a Node
Every node follows the same convention :
```swift
Node(ContentType,
     style: ((NodeType) -> Void),
     layout: ((NodeType) -> Void),
     ref: UnsafeMutablePointer<NodeType>,
     children: [Renderable])
```
For example a `Label` :

```swift
Label("My first Label",
     style: { $0.textColor = .red },
     layout: { $0.centerInContainer() },
     ref:  &lablel,
     children: [
        // Add Child nodes here
     ])
```
What's cool is that everything is optional so that you can just write :

```swift
Label("My first Label")
```

#### Content
The first parameter is the content, for instance an image for an `Image` node, some text for a `Label`.

#### Style
The style parameter is where you customize the `UIKit` object.
Just style your object however you want, say modify it's `backgroundColor`!

#### Layout
Notice we strongly separated the `layout` and the `style` parameters.
Though they are both called with the UIKit object, we believe it's clearer to seperate what is styling from what is in the layout domain.

Once again we want to play nice with UIKit and in this block you can use **pure Autolayout**.
We want to stress this point because it's a major advantage of this tool.
We like to use [Stevia](https://github.com/freshOS/Stevia), but be **free to use whatever layout
library that suits your needs** !

#### Ref

This will come very useful for falling back to the classic way of doing things.


```swift
class MyComponent: StatelessComponent {

    var labelReference = UILabel()

    func render() -> Node {
        return Label("My text", ref: &labelReference)
    }

    func foo() {
      // Later you can access the label and fall back to the old way of doing thing!
      labelReference.text = "Yay I'm not stuck in this !"
    }
}
```

#### Children
This is just an array of the nested nodes.


## View-Wrapped Component
Display your component in a UIView and use it wherever You want!
```swift
let view = ComponentView(component: MyComponent())
```
## ViewController-Wrapped Component
Embbed your component in view Controller and present it anyway you want :)
```swift
let vc = ComponentVC(component: MyComponent())
```
## Looping !

```swift
func render() -> Node {
    let items = ["Hello", "How", "Are", "You?"]
    return
        View(style: { $0.backgroundColor = .white }, [
            VerticalStack(style: { $0.spacing = 40 }, layout: { $0.centerInContainer() },
                items.map { Label($0) }
            )
        ])
}
```

## Example:  A Loading Screen
```swift
import UIKit
import Stevia
import Weact

class LoadingScreen: UIViewController, StatelessComponent {

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func loadView() { loadComponent() }

    func render() -> Node {
        return
            View(style: { $0.backgroundColor = .darkGray }, [
                HorizontalStack(style: { $0.spacing = 8 }, layout: {$0.centerInContainer() }, [
                    Label("Loading...", style: { $0.textColor = .white }),
                    ActivityIndicatorView(.white, style: { $0.startAnimating() })
                ])
            ])
    }
}
```
<img src="loadingScreen.png" alt="Loading" width="250">


## More Examples
Take a look at the example Project `WeactExample.xcodeproj` and play around !

<img src="examples.png" alt="Examples" width="250">

## Installation

### Carthage
```
github "s4cha/Weact"
```

### Manually
Simply Copy and Paste all the `.swift` files from the `Source` folder  in your Xcode Project :)

### Cocoapods
Coming soon

## Contributors
[YannickDot](https://github.com/YannickDot),
[S4cha](https://github.com/S4cha), YOU ?!  
We'd love to hear what you think so don't hesitate to reach out through an issue or via twitter
[@sachadso](https://twitter.com/sachadso)

## Inspiration
[Facebook's React](https://facebook.github.io/react/), [ComponentKit](https://github.com/facebook/componentkit),
[Preact](https://github.com/developit/preact), [Vue.js](https://vuejs.org) AlexDrone's render, Angular...
Pure Swift React/ ComponentKit implementation

## Other great libraries
We're not the first to tackle the great endeavor of swift components and here are some other very cool projects :
 - [Alexdrone's render](https://github.com/alexdrone/Render)
 - [joshaber's Few.swift](https://github.com/joshaber/Few.swift/tree/master/FewDemo)
 - [BendingSpoons' katana](https://github.com/BendingSpoons/katana-swift)
