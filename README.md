# Weact
Pure Swift React/ ComponentKit implementation

- Facebook's great ComponentKit is in Objc-C objc++, here we can leverage swift awesoemness.

## Requirements


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
