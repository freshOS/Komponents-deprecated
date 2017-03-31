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
 
=========== TODO
 
 - test change state button
 
 
 - INject source == Rerender Component.
 
- Need to be able to implement it gradually in a n implementation
- local reasoning
- changing one thing or updating one constraint needs to be in only one place.
 
 - test if state
 - test update state

- Open to using whatever layout system you need
(our favorite is Stevia (native autolayout))

- Works with NATIVE Autolayout

support live reload


- First rerender all on state change. is this dependent?
- Diif algorithm ?


Componennt<A State > ?? test

== func render(aState)


return NodeType

Node<UIImageView> etc


save on github private? first


separat node from UIViews>


viewForComponent(c) -> UIVIew {
    
}


MyComponenet: CompositeCOmponenet <aState, aProps, aView>


override func render() -> Element {
    
}


UIKitRenderer.render(component(MyComponent.self), container: self.view, context: self) { component in
    self.component = component
}


componenet.udpateState -> rerender = dirty

// Test update state in button
*/


// Compoenetn == node?
