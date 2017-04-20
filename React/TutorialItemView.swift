//
//  TutorialItemView.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 19/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia

// Not using React way (continuos state)
// Only render once on init

// need to store / pass references to acces (poke) the from a controller.

// test $0.style {  } instead of using params.

// TODO ViewLayout with spacies and margins in the childrne's aray ??



// fill the view by default.


// Manual layout through refs.

//        return View(layout: { $0.fillContainer() }, [
//            View(style: visualStyle, layout: { $0.top(95).centerHorizontally().size(260)}, []),
//            Text("Title", style:titleStyle, layout: { $0.centerInContainer() }),
//            Text("Detail", style: detailStyle, layout: { |-60-$0-60-| })
//        ])
//        return View(
//            layout: {
//                $0.fillContainer()
//
//                $0.layout(
//                    32,
//                    self.title,
//                    14,
//                    self.detail
//                )
////                self.title.top(100)
////                self.detail.top(200)
//        }, [
//            View(style: visualStyle, layout: { $0.top(95).centerHorizontally().size(260)}, []),
//            Text("Title", style:titleStyle, layout: { $0.centerHorizontally() }, ref: &title),
//            Text("Detail", style: detailStyle, layout: { |-60-$0-60-| }, ref: &detail)
//        ])
//return
//    View(style: { $0.backgroundColor = .white }, layout: { $0.fillContainer() }, [
//        VerticalStack(style: { $0.spacing = 30 }, layout: { $0.centerInContainer() }, [
//            View(style: visualStyle, layout: { $0.top(95).centerHorizontally().size(260)}, []),
//            Text("GPS", style:titleStyle, layout: { $0.centerHorizontally() }, ref: &title),
//            Text("Localisez votre animal en temps réel, soyez alerté en cas de fugue. ", style: detailStyle, layout: { |-60-$0-60-| }, ref: &detail)
//            ])
//        ])


class TutorialItemView: UIView, NodeView {
    
    let visual = UIImageView()
    var title = UILabel()
    var detail = UILabel()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }

    func node() -> Node {
        return View(style: { $0.backgroundColor = .white }, layout: { $0.fillContainer() }, [
            95,
            View(style: visualStyle, layout: { $0.centerHorizontally().size(260)}, []),
            32,
            Text("GPS", style:titleStyle, layout: { $0.centerHorizontally() }, ref: &title),
            14,
            [60, Text("Localisez votre animal en temps réel, soyez alerté en cas de fugue. ", style: detailStyle, ref: &detail), 60]
        ])
    }
    
    // Styles
    
    func visualStyle(v: UIView) -> Void {
        v.backgroundColor = .gray
        v.contentMode = .center
    }
    
    func titleStyle(l: UILabel) -> Void {
        l.font = UIFont(name: "OpenSans-Semibold", size: 17)
        l.textColor = UIColor(red: 0.66, green: 0.7, blue: 0.17, alpha: 1)
        l.textAlignment = .center
    }
    
    func detailStyle(l: UILabel) -> Void {
        l.font = UIFont(name: "OpenSans", size: 15.5)
        l.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.15, alpha: 1)
        l.textAlignment = .center
        l.numberOfLines = 0
    }
}


class OldTutorialItemView: UIView {
    
    let visual = UIImageView()
    let title = UILabel()
    let detail = UILabel()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        sv(
            visual,
            title,
            detail
        )
        
        let isUnderIPhone6 = UIScreen.main.bounds.width < 375
        
        layout(
            isUnderIPhone6 ? 20 : 95,
            visual.centerHorizontally().size(260),
            32,
            title.centerHorizontally(),
            14,
            |-60-detail-60-|,
            0
        )
        
        visual.contentMode = .center
        title.style { l in
            l.font = UIFont(name: "OpenSans-Semibold", size: 17)
            l.textColor = UIColor(red: 0.66, green: 0.7, blue: 0.17, alpha: 1)
        }
        detail.style { l in
            l.font = UIFont(name: "OpenSans", size: 15.5)
            l.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.15, alpha: 1)
            l.textAlignment = .center
            l.numberOfLines = 0
        }
    }
}
