//
//  UIViewController+Push.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 16/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

extension UIViewController {
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
