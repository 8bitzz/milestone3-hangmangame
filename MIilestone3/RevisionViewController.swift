//
//  RevisionViewController.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/9/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class RevisionViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var challangeWords: [Vocab] = []
    var letterButtons: [UIButton] = []
    var score = 0
    var attempt = 0
    var word = ""
    var hiddenAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view2)
        
        view1.widthAnchor.constraint(equalToConstant: 350).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 105).isActive = true
        view1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view1.bottomAnchor.constraint(equalTo: view2.topAnchor).isActive = true
        view1.backgroundColor = .white
        
        view2.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view2.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        view2.backgroundColor = .white
        
        for row1 in 0..<3 {
            for col1 in 0..<7 {
                let button = UIButton(type: .system)
                configure(button: button)
                
                let width = 50
                let height = 35
                let frame = CGRect(x: col1*width, y: row1*height, width: width, height: height)
                button.frame = frame
                view1.addSubview(button)
                letterButtons.append(button)
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
        
        for row2 in 0..<1 {
            for col2 in 0..<5 {
                let button = UIButton(type: .system)
                configure(button: button)
                
                let width = 50
                let height = 35
                let frame = CGRect(x: col2*width, y: row2*height, width: width, height: height)
                button.frame = frame
                view2.addSubview(button)
                letterButtons.append(button)
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
            }
        }
        
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for (index, name) in alphabet.enumerated() {
            letterButtons[index].setTitle(name, for: .normal)
        }
        
        loadGame()
        
    }
    
    @IBAction func restartButton(_ sender: Any) {
        score = 0
        loadGame()
    }

    @IBAction func nextButton(_ sender: Any) {
        loadGame()
    }
    
    func configure(button: UIButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.init(red: 247.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    func loadGame() {
        attempt = 0
        guard let revisedWord = challangeWords.randomElement() else { return }
        word = revisedWord.title.uppercased()
        
        hiddenAnswer = Array(repeating: "?", count: word.count).joined()
        answerLabel.text = hiddenAnswer
        answerLabel.textColor = UIColor.red
        hintLabel.text = revisedWord.definition
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        attempt += 1
        if attempt <= 7 {
            guard let buttonTitle = sender.titleLabel?.text else { return }
            var characterSets = Array(hiddenAnswer)
            guard word.contains(buttonTitle) else { return }
            for (i, character) in word.enumerated() {
                guard String(character) == buttonTitle else { continue }
                characterSets[i] = character
            }
            hiddenAnswer = String(characterSets)
            answerLabel.text = hiddenAnswer
            if hiddenAnswer == word {
                let ac = UIAlertController(title: "Excellent!", message: "You've owned this word", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(ac, animated: true)
                score += 1
                loadGame()
            }
        } else {
            let ac = UIAlertController(title: "Oops!", message: "You've missed this word", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true)
            hiddenAnswer = Array(repeating: "?", count: word.count).joined()
            answerLabel.text = hiddenAnswer
            score += -1
            loadGame()
        }
    }
}
