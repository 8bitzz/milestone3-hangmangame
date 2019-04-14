//
//  ViewController.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/8/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class TopicViewController: UITableViewController, UITextFieldDelegate {
    var topics = TopicList()
    var submitAction: UIAlertAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Topics"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        cell.textLabel?.text = topics.list[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VocabTableViewController") as! VocabTableViewController
        vc.collectedWords = topics.list[indexPath.row].collectedWords
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        topics.removeTopic(at: indexPath)
        tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        let ac = UIAlertController(title: "New topic", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter a new topic here"
            textField.delegate = self
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let topicName = ac?.textFields?[0].text else { return }
            self?.topics.add(newTopic: Topic(name: topicName))
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        ac.addAction(submitAction)
        submitAction.isEnabled = false
        self.submitAction = submitAction
        present(ac, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            submitAction?.isEnabled = false
        } else {
            submitAction?.isEnabled = true
        }
        return true
    }
}

