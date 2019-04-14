//
//  VocabTableViewController.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class VocabTableViewController: UITableViewController {
    var collectedWords: VocabList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocabulary"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        let reviseButton = UIBarButtonItem(title: "Review", style: .plain, target: self, action: #selector(reviseButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let dictionaryButton = UIBarButtonItem(title: "Dictionary", style: .plain, target: self, action: #selector(dictionaryButtonTapped))
        
        toolbarItems = [reviseButton, spaceButton, dictionaryButton]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vocab = collectedWords else { return 1 }
        return vocab.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
        guard let vocab = collectedWords else { return UITableViewCell() }
        cell.textLabel?.text = vocab.list[indexPath.row].title
        cell.detailTextLabel?.text = vocab.list[indexPath.row].definition
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let collectedWords = collectedWords else { return }
        collectedWords.removeVocab(at: indexPath)
        tableView.reloadData()
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
            self?.collectedWords?.add(newVocab: Vocab(title: wordName, definition: wordDefinition))
            self?.tableView.reloadData()
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    @objc func reviseButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RevisionViewController") as? RevisionViewController else { return }
        guard let words = collectedWords?.list,
                    words.count > 0 else {
                        let ac = UIAlertController(title: "Oops !", message: "No words for reviewing \nPlease add some new vocabulary.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true)
            return
        }
        vc.challangeWords = words
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dictionaryButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DictionaryViewController") as? DictionaryViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
