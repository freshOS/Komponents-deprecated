class UIKitReconcilier {

    class func walk (_ oldNode: UIView?, _ newNode: UIView?) -> UIView? {
        if let old = oldNode {
            if let new = newNode {
                if (new == old) {
                    return old
                } else {
                    smash(old, new)
                    updateChildren(new, old)
                    return old
                }
            } else {
                return nil
            }
        } else {
            return newNode
        }

    }

    class func smash(_ oldNode: UIView, _ newNode: UIView) {
        // read each node attributes and diff them
        // then patch the old node (side-effect)

        // - layout
        // - events
    }

    class func updateChildren(_ oldNode: UIView, _ newNode: UIView) {
        var newLength = newNode.subviews.count
        var oldLength = oldNode.subviews.count
        var length = max(oldLength, newLength)

        var iNew = 0
        var iOld = 0
        var i = 0

        while i < length {
            var newChildNode = newNode.subviews[iNew]
            var oldChildNode = oldNode.subviews[iOld]
            var retChildNode = walk(newChildNode, oldChildNode)

            if (retChildNode == nil) {
                if (oldChildNode != nil) {
                    oldNode.subviews.remove(at: i)
                    iOld = iOld-1
                }
            } else if (oldChildNode == nil) {
                if (retChildNode) {
                    oldNode.subviews.append(retChildNode)
                    iNew = iNew- 1
                }
            } else if (retChildNode != oldChildNode) {
                oldNode.subviews.remove(at: i)
                oldNode.subviews.insert(retChildNode, at: i)
                iNew = iNew- 1
            }

            i = i+1
            iNew = iNew+1
            iOld = iOld+1
        }
    }
}
