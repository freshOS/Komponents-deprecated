//
//  States.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation


protocol Post {
    var title:String { get }
    var detail:String { get }
    var numberOfYummys: Int { get }
    var numberOfcomments: Int { get }
}

struct Photo: Post {
    var title = "JOhn Doe"
    var detail = "Super Cool bro"
    var numberOfYummys = 973
    var numberOfcomments = 12
}
