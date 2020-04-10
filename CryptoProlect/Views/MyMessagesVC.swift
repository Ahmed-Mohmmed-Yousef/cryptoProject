//
//  MyMessagesVC.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class MyMessagesVC: UIViewController {
    
    var messagesMV: MessagesMV!
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "MsgCell")
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        // Do any additional setup after loading the view.
        self.setupNavBar()
        self.setupViews()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.messagesMV.delegate = self
    }
    
    fileprivate func setupNavBar(){
        navigationItem.title = "My Masseges"
    }
    
    fileprivate func setupViews(){
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }

}

extension MyMessagesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesMV?.messagsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "MsgCell")
        guard let message = messagesMV?.getMessage(at: indexPath.row) else { return UITableViewCell() }
        cell.textLabel?.text = message.message
        cell.detailTextLabel?.text = "\(message.date)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension MyMessagesVC: MessgesDelegate{
    
}
