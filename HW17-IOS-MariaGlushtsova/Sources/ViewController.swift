//
//  ViewController.swift
//  HW17-IOS-MariaGlushtsova
//
//  Created by Admin on 9.08.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray
        label.text = "Password"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 10
        label.layer.shouldRasterize = true
        label.layer.rasterizationScale = UIScreen.main.scale
        return label
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
        textField.placeholder = "Create password"
        return textField
    }()
    
    private lazy var createPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(createPassword), for: .touchUpInside)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 20
        button.setTitle("Create Password", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(createPasswordButton)
    }
    
    private func setupLayout() {
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).offset(-150)
        }
        
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        createPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(passwordField).offset(100)
        }
    }
    
    // MARK: - Actions
    
    @objc private func createPassword() {
       print("Password")
    }
}
