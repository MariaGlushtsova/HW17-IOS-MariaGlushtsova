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
        label.text = ""
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
        textField.isSecureTextEntry = false
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
        
//        self.bruteForce(passwordToUnlock: passwordField.text ?? String())
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
        bruteForce(passwordToUnlock: passwordField.text ?? String())
//        print(passwordField.text.self ?? String())
//        print("Password")
    }
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWOR;D_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
//             Your stuff here
            print(password)
            // Your stuff here
        }

        print(password)
        passwordLabel.text = password
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}
