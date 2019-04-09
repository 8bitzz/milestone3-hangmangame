//
//  VocabList.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class VocabList {
    var vocabList: [Vocab] = []
    
    func add(newVocab: Vocab) {
        vocabList.insert(newVocab, at: 0)
    }
    
    func removeVocab(at indexPath: IndexPath) {
        vocabList.remove(at: indexPath.row)
    }
    
    func removeAll() {
        vocabList.removeAll()
    }
}
