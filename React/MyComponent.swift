//
//  MyComponent.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import Stevia
import UIKit
//class ClassicView :UIView {
//    
//    let title = UILabel()
//    let detail = UILabel()
//    let content = UILabel()
//    
//    convenience init() {
//        self.init(frame: CGRect.zero)
//        setup()
//    }
//    
//    func setup() {
//        
//        sv(
//            title,
//            detail,
//            content
//        )
//        
//        layout (
//            80,
//            |-title-|,
//            |-detail-|,
//            |-content-|
//        )
//        
//        backgroundColor = .white
//        
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.text = "Title"
//        title.font = UIFont(name: "HelveticaNeue-Light", size: 30)
//
//        detail.translatesAutoresizingMaskIntoConstraints = false
//        detail.text = "Detail"
//        detail.font = UIFont(name: "HelveticaNeue", size: 20)
//    
//        content.translatesAutoresizingMaskIntoConstraints = false
//        content.text = "Content"
//        content.numberOfLines = 0
//        content.font = UIFont(name: "HelveticaNeue", size: 15)
//    }
//}
//
//class ClassicViewComponent: Component {
//    func render() -> UIView {
//        return View(style: { $0.backgroundColor = .white }, children:
//                    VerticalStack( layout: { $0.top(80) }, children:
//                        Text("Title",style : { $0.font = UIFont(name: "HelveticaNeue-Light", size: 30)} ),
//                        Text("Detail",  style : { $0.font = UIFont(name: "HelveticaNeue", size: 20)} ),
//                        Text("Content", style : { $0.font = UIFont(name: "HelveticaNeue", size: 15)} )
//            )
//        )
//    }
//}


//class PhotoTableViewCell: UITableViewCell {
//    
//    init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        self(
//        
//        let v = PhotoFeedCell.new(with: <#T##Photo#>)
//        self.cont
//    }
//}


//class SubComponent {
//  
//    static func build(text:String) -> Component {
//        return Text(text, layout: { $0.centerInContainer() })
//    }
//    
////    // working calling super setup stuf
////        static func build(text:String) -> Component {
////            return CustomComponent.newWith(
////                Text(text)
////            )
////        }
//}
//
//    func newWithPost(post: Post) -> TestComponent {
//        return View(style: { $0.backgroundColor = .white }, children:
//            VerticalStack( layout: { $0.top(80) }, children:
//                Text("Title",style : { $0.font = UIFont(name: "HelveticaNeue-Light", size: 30) } ),
//                           Text("Detail",  style : { $0.font = UIFont(name: "HelveticaNeue", size: 20)} ),
//                           Text("Content", style : { $0.font = UIFont(name: "HelveticaNeue", size: 15)} )
//            )
//        )
//    }
//}

//
//class FeedPostComponent: Component {
//    func render() -> UIView {
//        return View(children:
//            FeedBottomComponent(layout: { c in
//                c.
//            })
//        )
//    }
//}

// TODO sub components???

//class FeedBottomComponent: Component {
//    
//    func render() -> UIView {
//        
//        
//        let yummy = Text("25 Yummies")
//        let comment = Text("12 Comments")
//        
//        return View(style: { $0.backgroundColor = .white },
//                    layout: { v in
//                        yummy.centerInContainer()
//                    },
//                    children:
////                HorizontalStack( layout: { $0.top(80) }, children:
//                    yummy, comment
////            )
//        )
//    }
//}

//struct FeedCellBottomComponent: CellComponent {
//    
//    var yummyButton = LargeTapAreaButton()
//    var numberOfYummys = UILabel()
//    var commentsButton = LargeTapAreaButton()
//    var numberOfComments = UILabel()
//    var moreButton = LargeTapAreaButton()
//    
//    func render(in cell: UITableViewCell) {
//        
//        cell.sv(
//            yummyButton,
//            numberOfYummys,
//            commentsButton,
//            numberOfComments,
//            moreButton
//        )
//        
//        let sm: CGFloat = (isIPad() ? iPadSideMargin : 0) + 16
//        yummyButton.bottom(20)
//        numberOfYummys.width(>=28)
//        numberOfComments.width(>=28)
//        alignHorizontally(|-sm-yummyButton-6-numberOfYummys-6-commentsButton-6-numberOfComments-""-moreButton-sm-|)
//        
//        yummyButton.style(feedYummyButtonStyle)
//        numberOfYummys.style(feedCountStyle)
//        commentsButton.style(feedCommentsButtonStyle)
//        numberOfComments.style(feedCountStyle)
//        moreButton.style(feedMoreButtonStyle)
//    }
//}


//class FeedBottomComponentNoStack: Component {
//    
//    func render() -> UIView {
//        return render(post:Post())
//    }
//    
//    func render(post: Post) -> UIView {
//        
//        var yummyButton: Button!
//        var yummy: Text!
//        var comment: Text!
//        var commentButton: Button!
//        var moreButton: Button!
//        
//        return View(style: { $0.backgroundColor = .white },
//                    layout: { _ in
//                        // Readable layout in one place.
//                        yummyButton.centerVertically()
//                        yummyButton.size(50)
//                        alignHorizontally(
//                            |-yummyButton-yummy-commentButton-comment-(>=8)-moreButton-|
//                        )
//        },
//                    children:
//            Button(ref:&yummyButton),
//                    Text("\(post.numberOfYummys)", ref:&yummy),
//                    Button(ref:&commentButton),
//                    Text("\(post.numberOfcomments)", ref:&comment),
//                    Button(ref:&moreButton)
//        )
//    }
//}

// selectors

// React / DEclarative is less error prone taht imperative. Describe your layout rather than code it
// LOCAL Reasoning
// Self contained --. rm 1 thing = rm in 1 place only
//
//struct Post: Component {
//    
//    func render() -> UIView {
//        return FeedBottomComponent().render()
//    }
    
//    func render() -> View {
//        return View(style:{
//            $0.backgroundColor = .white
//        }, children:
//            View(style: {
//                $0.backgroundColor = .blue
//            }, layout: {
//                $0.centerInContainer()
//                $0.size(100)
//            }, children:
//                Text("Hello", style: {
//                    $0.backgroundColor = .red
//                }, layout: {
//                    $0.centerInContainer()
//                    $0.size(50)
//                })
//            )
//        )
//    }
    
//    struct Props {
//        var isSpaced = false
//    }
//    
//    func render() -> UIView {
//        return View( style: { $0.backgroundColor = .white }, children:
//            VerticalStack( style: { $0.spacing = 20 },
//                layout: { $0.centerInContainer() },
//                children:
//                Text("Hello, There", style: { $0.backgroundColor = .blue }),
//                Text("Hello, Here"),
//                Text("Hello Again!"),
//                Text("Hello, YO"),
//                Text("Hello, HII")
//            )
//        )
    

//        return View(style: { $0.backgroundColor = .white },
//                    children:
//                    Text("Hello world",
//                         style: { $0.font = UIFont.systemFont(ofSize: 30) },
//                         layout: { $0.centerInContainer() })
//        )
//    }
//}

//<View style:{ $0.backgroundColor = .white } >
//    <View(style: { $0.backgroundColor = .blue},
//          layout: {
//                $0.centerInContainer()
//                $0.size(100)
//        }
//        <View style: { $0.backgroundColor = .red }
//            , layout: {
//            $0.centerInContainer()
//            $0.size(50)
//        }
//        </View>
//    </View>
//</View>


