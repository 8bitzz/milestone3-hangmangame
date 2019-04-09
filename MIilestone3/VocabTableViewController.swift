//
//  VocabTableViewController.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class VocabTableViewController: UITableViewController {
    var vocabList: VocabList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocabulary"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vocab = vocabList else { return 1 }
        return vocab.vocabList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
        guard let vocab = vocabList else { return UITableViewCell() }
        cell.textLabel?.text = vocab.vocabList[indexPath.row].word
        cell.detailTextLabel?.text = vocab.vocabList[indexPath.row].definition
        return cell
    }
    
    @objc func addButtonTapped() {
        let ac = UIAlertController(title: "New vocabulary", message: nil, preferredStyle: .alert)
        ac.addTextField { (wordName) in
            wordName.placeholder = "Enter a new word here"
        }
        ac.addTextField { (wordDefinition) in
            wordDefinition.placeholder = "Enter short meaning here"
        }
        let addAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
            guard let wordName = ac?.textFields?[0].text,
            let wordDefinition = ac?.textFields?[1].text else { return }
            self?.vocabList?.add(newVocab: Vocab(word: wordName, definition: wordDefinition))
            self?.tableView.reloadData()
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }

}
