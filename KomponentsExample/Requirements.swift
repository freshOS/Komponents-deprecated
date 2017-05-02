//
//  Requirements.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation

/*
Requirements :

=========== OK
- ComponentKit is in Objc-C objc++, here we can leverage swift awesoemness.
- Pure SWIFT
- No dependency of layout library
- View is returned in function of a state
- Both components and Nodes need to be renderable
- test render every second
 - Componenet can call "upadte state method"
 - Calls to "upadtestate" which cahnges state and triggers rerender.
 - test change state button
 - No timer, triger state updates
 - Open to using whatever layout system you need
 (our favorite is Stevia (native autolayout))
 - Works with NATIVE Autolayout
=========== TODO

 - Support  nested sub componenets
 - INject source == Rerender Component.
- Need to be able to implement it gradually in a n implementation
- local reasoning
- changing one thing or updating one constraint needs to be in only one place.
support live reload
- First rerender all on state change. is this dependent?
- Diif algorithm ?


UIKitRenderer.render(component(MyComponent.self), container: self.view, context: self) { component in
    self.component = component
}


componenet.udpateState -> rerender = dirty


*/

// - ListView / collections view ?
// Sub componenets

// test map Text in Vertical Stack!
