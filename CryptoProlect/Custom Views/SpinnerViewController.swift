//
//  SpinnerViewController.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/10/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var text: String?

    override func loadView() {
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1322597265, green: 0.1322893202, blue: 0.1322558224, alpha: 0.1469659675)
        
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 10.0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        containerView.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.text = text == nil ? "loading..." : text
        lbl.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 32).isActive = true
        lbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
}
