//
//  UIKitReconcilier+Patch.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 17/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

extension UIKitReconcilier {
    
    func smash(_ oldNode: IsNode, _ newNode: IsNode) {
        
        // Patch Layout
        if newNode.layout != oldNode.layout {
            if let uiView = engine?.renderer.nodeIdViewMap[newNode.uniqueIdentifier] {
                log("💉 Patch Layout")
                updates.append {
                    // remove all previous layout constraints
                    uiView.removeConstraints(uiView.constraints)
                    
                    // Apply new layout
                    if let superview = uiView.superview {
                        layout(uiView, withLayout: newNode.layout, inView: superview)
                    }
                }
            }
        }
        
        // View
        if let view = oldNode as? View, let newView = newNode as? View {
            if newView.props.backgroundColor != view.props.backgroundColor {
                if let uiView = engine?.renderer.nodeIdViewMap[newView.uniqueIdentifier] {
                    updates.append {
                        uiView.backgroundColor = newView.props.backgroundColor
                    }
                    log("💉 Patch BackgroundColor")
                }
            }
        }
        //
        //        if newNode.isHidden != oldNode.isHidden {
        //            let c = newNode.isHidden
        //            updates.append {
        //                oldNode.isHidden = c
        //            }
        //            log("💉 Patch isHidden")
        //        }
        //
        //        if newNode.alpha != oldNode.alpha {
        //            let c = newNode.alpha
        //            updates.append {
        //                oldNode.alpha = c
        //            }
        //            log("💉 Patch alpha")
        //        }
        //
        
        // Label
        if let label = oldNode as? Label, let newLabel = newNode as? Label {
            if newLabel.props.text != label.props.text {
                if let uiLabel = engine?.renderer.nodeIdViewMap[newLabel.uniqueIdentifier] as? UILabel {
                    log("💉 Patch text")
                    updates.append {
                        uiLabel.text = newLabel.props.text
                    }
                }
            }
            
            if newLabel.props.textColor != label.props.textColor {
                if let uiLabel = engine?.renderer.nodeIdViewMap[newLabel.uniqueIdentifier] as? UILabel {
                    log("💉 Patch textColor")
                    updates.append {
                        uiLabel.textColor = newLabel.props.textColor
                    }
                }
            }
        }
        
        // Button
        if let button = oldNode as? Button, let newButton = newNode as? Button {
            
            // Text
            if newButton.props.text != button.props.text {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? UIButton {
                    log("💉 Patch text")
                    updates.append {
                        uibutton.setTitle(newButton.props.text, for: .normal)
                    }
                }
            }
            
            // Image
            if newButton.props.image != button.props.image {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? UIButton {
                    log("💉 Patch image")
                    updates.append {
                        uibutton.setImage(newButton.props.image, for: .normal)
                    }
                }
            }
            
            // isEnabled
            if newButton.props.isEnabled != button.props.isEnabled {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? UIButton {
                    log("💉 Patch isEnabled")
                    updates.append {
                        uibutton.isEnabled = newButton.props.isEnabled
                    }
                }
            }
            
            // BackgroudnColor
            if newButton.props.backgroundColorForNormalState != button.props.backgroundColorForNormalState {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? BlockBasedUIButton {
                    log("💉 Patch backgroudnColor")
                    updates.append {
                        if let backgroundColorForNormalState = newButton.props.backgroundColorForNormalState {
                            uibutton.setBackgroundColor(backgroundColorForNormalState, for: .normal)
                        }
                    }
                }
            }
        }
        
        // Image
        if let image = oldNode as? Image, let newImage = newNode as? Image {
            if newImage.props.image != image.props.image {
                if let uiimage = engine?.renderer.nodeIdViewMap[newImage.uniqueIdentifier] as? UIImageView {
                    log("💉 Patch image")
                    updates.append {
                        uiimage.image = newImage.props.image
                    }
                }
            }
        }
        
        // ActivityIndicatorView
        if let spinner = oldNode as? ActivityIndicatorView, let newSpinner = newNode as? ActivityIndicatorView {
            if newSpinner.props.isHidden != spinner.props.isHidden {
                if let uiSpinner = engine?.renderer.nodeIdViewMap[newSpinner.uniqueIdentifier]
                    as? UIActivityIndicatorView {
                    log("💉 Patch isHidden")
                    updates.append {
                        if newSpinner.props.isHidden {
                            uiSpinner.stopAnimating()
                        } else {
                            uiSpinner.startAnimating()
                        }
                    }
                }
            }
        }
        
        // Field
        if let field = oldNode as? Field, let newField = newNode as? Field {
            if newField.props.text != field.props.text {
                if let uitextField = engine?.renderer.nodeIdViewMap[newField.uniqueIdentifier] as? UITextField {
                    log("💉 Patch text")
                    updates.append {
                        uitextField.text = newField.props.text
                    }
                    
                    // Update NodeID - View Map
                    
                }
            }
            
            //            if newLabel.textColor != label.textColor {
            //                updates.append {
            //                    label.textColor = newLabel.textColor
            //                }
            //                log("💉 Patch textColor")
            //            }
        }
        
        //        if let button = oldNode as? UIButton, let newButton = newNode as? UIButton {
        //            if newButton.backgroundImage(for: .normal) != button.backgroundImage(for: .normal) {
        //                let img = newButton.backgroundImage(for: .normal)
        //                updates.append {
        //                    button.setBackgroundImage(img, for: .normal)
        //                }
        //                log("💉 Patch backgroundImage")
        //            }
        //
        //            if newButton.title(for: .normal) != button.title(for: .normal) {
        //                let text = newButton.title(for: .normal)
        //                updates.append {
        //                    button.setTitle(text, for: .normal)
        //                }
        //                log("💉 Patch Title")
        //            }
        //
        //
        //        }
        //
        //
        //        // Image
        //        if let image = oldNode as? UIImageView, let newImage = newNode as? UIImageView {
        //            if newImage.image != image.image {
        //                let img = newImage.image
        //                updates.append {
        //                    image.image = img
        //                }
        //                log("💉 Patch Image")
        //            }
        //        }
        //
        //
        //        // Switch
        //        if let oldSwitch = oldNode as? UISwitch, let newSwitch = newNode as? UISwitch {
        //            if newSwitch.isOn != oldSwitch.isOn {
        //                updates.append {
        //                    oldSwitch.isOn = newSwitch.isOn
        //                }
        //                log("💉 Patch isON")
        //            }
        //
        //        }
    }
}
