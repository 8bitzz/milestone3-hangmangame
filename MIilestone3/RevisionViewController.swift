//
//  RevisionViewController.swift
//  MIilestone3
//
//  Created by Hang Nguyen on 4/9/19.
//  Copyright © 2019 8bitzz. All rights reserved.
//

import UIKit

class RevisionViewController: UIViewController {
    var revisedWords: [Vocab] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonView)
        
        buttonView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        buttonView.backgroundColor = .white
        
        for row in 0..<3 {
            for col in 0..<7 {
                let button = UIButton(type: .system)
                configure(button: button)
                
                let width = 50
                let height = 35
                let frame = CGRect(x: col*width, y: row*height, width: width, height: height)
                button.frame = frame
                
                buttonView.addSubview(button)
            }
        }
    }
    
    func configure(button: UIButton) {
        button.setTitle("W", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.init(red: 247.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    

}
