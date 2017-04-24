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

