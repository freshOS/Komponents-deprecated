# Weact ⚛️
Weact = Swift + React

```swift
func render() -> Node {
    return
        View(style: { $0.backgroundColor = .white }, [
            Label("Hello Components!", layout: { $0.centerInContainer() })
        ])
}
```
Weact is a Swift framework for building component-oriented interfaces.

[Facebook's React guide](https://facebook.github.io/react/) is an incredible documentation to get familiar with the concept.


|      | Weact                                   |
| ---- | ---------------------------------------- |
|  🔶  | Pure **Swift** (no JS, no XML)           |
|  🏗    | Can be used **Incrementally** |
|   📐  |Can use **Autolayout or any autolayout** lib for the layout (we like [Stevia](https://github.com/freshOS/Stevia)) |
| 💉 | Supports **Hot Reload** with [💉 injectionForXcode](http://johnholdsworth.com/injection.html)|

## Your first Component

```swift
import UIKit
import Stevia
import Weact

class MyButton: Component {

    var state = true // On/ Off

    func render() -> Node {
        let icon = state ? #imageLiteral(resourceName: "buttonIconOn") : #imageLiteral(resourceName: "buttonIconOff")
        return
            Button(
                tap: { [weak self] in self?.tapped() },
                style: { $0.setBackgroundImage(icon, for: .normal) }
            )
    }

    private var tapped = {}
    func tap(_ cb: @escaping () -> Void) { tapped = cb }

    func setPositionNotCentered() {
        updateState { $0 = false } // Calls to `upadteState` triggers a relayout.
    }

    func setPositionCentered() {
        updateState { $0 = true } // Calls to `upadteState` triggers a relayout.
    }
}
```

### View-Backed Component
Display your component in a UIView and use it wherever You want!
```swift
let view = ComponentView(component: MyComponent())
```
### ViewController-Backed Component
Embbed your component in view Controller and present it anyway you want :)
```swift
let vc = ComponentVC(component: MyComponent())
```
### Looping !

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


## Inspiration
[Facebook's React](https://facebook.github.io/react/), [ComponentKit](https://github.com/facebook/componentkit),
[Preact](https://github.com/developit/preact), [Vue.js](https://vuejs.org) AlexDrone's render, Angular...
Pure Swift React/ ComponentKit implementation

## Other great Swift libraries
[Alexdrone's render](https://github.com/alexdrone/Render)

[BendingSpoons' katana](https://github.com/BendingSpoons/katana-swift)
