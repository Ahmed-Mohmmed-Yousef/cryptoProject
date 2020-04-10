  
//
//  ReusableTextField.swift
//  marktApp
//
//  Created by Ahmed on 3/23/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//
import UIKit

class ReusableTextField: UIView {

    var imgView: UIImageView = {
        var imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.backgroundColor = .clear
        imgv.tintColor = .gray
        imgv.contentMode = .scaleAspectFit
        imgv.image = #imageLiteral(resourceName: "Typ_image_outline")
        return imgv
    }()
    
    lazy var textField: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 20.0)
        tf.tintColor = .darkGray
        tf.placeholder = "Place holder"
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.addCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImagView(){
        addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            imgView.widthAnchor.constraint(equalToConstant: 24),
            imgView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupTextField(){
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 2.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.0)
        ])
    }
    
    private func addCustomView(){
        setupImagView()
        setupTextField()
    }
    
}
