//
//  ViewController.swift
//  HW17-IOS-MariaGlushtsova
//
//  Created by Admin on 9.08.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var stopButtonIsTapped = false
    
    // MARK: - Outlets
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
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
    
    private lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var breakPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(breakPassword), for: .touchUpInside)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 20
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(stopBreakPassword), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.setTitle("Остановить подбор", for: .normal)
        button.setTitleColor(.black, for: .normal)
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
        view.addSubview(spinner)
        view.addSubview(breakPasswordButton)
        view.addSubview(stopButton)
    }
    
    private func setupLayout() {
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
        }
        
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(230)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }

        breakPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.centerX.equalToSuperview().offset(-80)
            make.centerY.equalTo(passwordField).offset(100)
        }
        
        stopButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.centerX.equalToSuperview().offset(80)
            make.centerY.equalTo(breakPasswordButton)
        }
    }
    
    // MARK: - Actions
    
    @objc private func breakPassword() {
        stopButtonIsTapped = false
        spinner.startAnimating()
        bruteForce(passwordToUnlock: passwordField.text ?? String())
    }
    
    @objc private func stopBreakPassword() {
        stopButtonIsTapped = true
        passwordField.isSecureTextEntry = true
        passwordLabel.text = "Пароль не взломан"
        spinner.stopAnimating()
    }
    
    func bruteForce(passwordToUnlock: String) {
        
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        DispatchQueue.global(qos: .background).async {
            
            while password != passwordToUnlock {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                DispatchQueue.main.sync {
                    self.passwordLabel.text = password
                }
                                
                if self.stopButtonIsTapped == true {
                    break
                }
            }
            
            if self.stopButtonIsTapped == false {
                DispatchQueue.main.sync {
                    self.passwordLabel.text = "Пароль \(password) взломан"
                    self.passwordField.isSecureTextEntry = false
                    self.spinner.stopAnimating()
                }
            } else {
                DispatchQueue.main.sync {
                    self.passwordLabel.text = "Пароль не взломан"
                    self.spinner.stopAnimating()
                }
            }
        }
    }
}
