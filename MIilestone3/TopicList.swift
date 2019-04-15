//
//  TopicList.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class TopicList {
    var list = [Topic]()
    
    func add(newTopic: Topic) {
        list.insert(newTopic, at: 0)
    }
    
    func removeTopic(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
    }
}
