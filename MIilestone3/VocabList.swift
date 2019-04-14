//
//  VocabList.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class VocabList {
    var list: [Vocab] = []
    
    func add(newVocab: Vocab) {
        list.insert(newVocab, at: 0)
    }
    
    func removeVocab(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
    }
}
