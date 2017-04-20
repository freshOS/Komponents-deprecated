# Weact
Pure Swift React/ ComponentKit implementation

- Facebook's great ComponentKit is in Objc-C objc++, here we can leverage swift awesoemness.

## Requirements

- [x] Can be used Incrementally
- [x] Can be used without React ( only the cool view building syntax )


### Ok
- Pure Swift
- No dependency of layout library (often flexbox in other impl)
- View is returned in function of a state
- Both Components and Nodes are Renderable
- Components can call `upadateState`
- Calls to `upadteState` triggers a relayout.
- Open to using whatever layout system you need
 (our favorite is Stevia (native autolayout))

### TODO
 - Support sub componenets
 - INject source == Rerender Component.

- Need to be able to implement it gradually in a n implementation
- First rerender all on state change. is this dependent?
- Diif algorithm ?
- Explore how to handle navigation and VC presenting/pushing

-- add references of objects for defered global layout.

- how would we attach Gesture recognizers?
- relayout/ refresh render/ but keep current selected field?


// 3 Both independent of the layout system, can use native autolayout or other (Stevia?)

## Example

```swift
class PhotoComponent: Component {

    var state: Photo = Photo()

    func render(state photo: Photo) -> Renderable {
        return
            VerticalStack(style: { $0.spacing = 50 }, layout: { $0.centerInContainer() }, [
                Button("Tap Me", tap: { self.updateState { $0.numberOfYummys += 1} }),
                Text("There"),
                Text("How"),
                Text("Are"),
                Text("\(photo.numberOfYummys)")
            ])
    }
}
```

### Use View building without React.

As a first step, you might want to migrate your classic UIView subclass to support the cool syntax. You're not ready to jump into react logic and break your app that works, Amen!
The following technique enables you to migrate your existing views to the new syntax, while staying plain UIViews. This means you won't have to change a single line of Controller code. YAY! \o/

Take your `UIView` subclass and make it a `DefaultNodeView` subclass.

```swift
class ActivityLine: DefaultNodeView {

    var square = UIView()
    var label = UILabel()
    var time = UILabel()
    var separator = UIView()

    override func node() -> Node {
        return View([
            View(style: { $0.backgroundColor = .red }, ref: &square, []),
            Text("Reposaaay", style:labelStyle, ref: &label),
            Text("4h32", style: labelStyle, ref: &time),
            View(style: { $0.backgroundColor = UIColor(r:29, g:29, b:38).withAlphaComponent(0.1) },
                 layout: { |$0.height(1).bottom(0)| }, ref: &separator, [])
        ])
    }

    override func layoutPass() {
        square.size(20)
        square.CenterY == CenterY + 1
        label.CenterY == CenterY + 2
        |-22-square-15-label-(>=8)-time-25-|
        alignHorizontally(label, time)
    }

    func labelStyle(l: UILabel) {
        l.font = UIFont(name: "OpenSans", size:14)
        l.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.15, alpha: 1)
    }
}
```
Usage is the same as before :
```swift
let myView = ActivityLine()
```

### How does it work?
Simple on `init`, `DefaultNodeView` just calls `node()` and renders the node hierarchy it inside itself :)
