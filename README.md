# Weact


## Inspiration
Facebook's React, ComponentsKit, AlexDrone's render, Angular...
Pure Swift React/ ComponentKit implementation

## Requirements
- [x] Pure **Swift** (no JS, no XML)
- [x] Can be used **Incrementally**
- [x] Can be used **Without React** ( only the cool view building syntax if you want to)
- [x] Can use **Autolayout or any autolayout** lib for the layout (we like
  [Stevia](https://github.com/freshOS/Stevia))
- [x] Support **Hot Reload** with [💉 injectionForXcode](http://johnholdsworth.com/injection.html)


### Details
- Component's view is rendered for a given state
- Components can call `upadateState`
- Calls to `upadteState` triggers a relayout.
- Open to using whatever layout system you need
 (our favorite is Stevia (native autolayout))

### TODO
 - Support sub components
 - INject source == Rerender Component.
- First rerender all on state change. is this dependent?
- Diif algorithm ?
- Explore how to handle navigation and VC presenting/pushing
- how would we attach Gesture recognizers?
- relayout/ refresh render/ but keep current selected field?

## Component = View + State

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

### NodeView = View Only (without React continous state change thing aka poke the views)

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
