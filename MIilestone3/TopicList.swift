//
//  TopicList.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class TopicList {
    var topicList = [Topic]()
    
    func add(newTopic: Topic) {
        topicList.insert(newTopic, at: 0)
    }
    
    func removeTopic(at indexPath: IndexPath) {
        topicList.remove(at: indexPath.row)
    }
    
    func removeAll() {
        topicList.removeAll()
    }
}
