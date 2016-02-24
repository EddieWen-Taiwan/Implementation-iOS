//
//  User.swift
//  Grace
//
//  Created by Eddie on 2/24/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import Foundation

struct User {

    var username: String
    var star: Float

    init(name: String, star: Float) {
        self.username = name
        self.star = star
    }

}