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
        label.text = ""
        label.textColor = UIColor(named: "Green")
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.textAlignment = .center
        textField.placeholder = "Create password"
        return textField
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor(named: "Green")
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var breakPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(breakPassword), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Green")
        button.layer.cornerRadius = 20
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
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
        button.backgroundColor = UIColor(named: "Purple")
        button.layer.cornerRadius = 20
        button.setTitle("Остановить подбор", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
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
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    private func setupHierarchy() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(spinner)
        view.addSubview(breakPasswordButton)
        view.addSubview(stopButton)
    }
    
    private func setupLayout() {
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(180)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-180)
        }
        
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(230)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }

        breakPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(160)
            make.centerX.equalToSuperview().offset(-100)
            make.centerY.equalTo(passwordField).offset(150)
        }
        
        stopButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(160)
            make.centerX.equalToSuperview().offset(100)
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
