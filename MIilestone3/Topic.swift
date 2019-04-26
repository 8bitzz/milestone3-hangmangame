//
//  Topic.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class Topic: Codable {
    var name: String
    var collectedWords = VocabList()
    
    init(name: String) {
        self.name =  name
    }
}
