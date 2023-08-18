//
//  MyController.swift
//  HW17-IOS-MariaGlushtsova
//
//  Created by Admin on 9.08.23.
//

import UIKit

class MyController: UIViewController {
    
    private var myView: MyView? {
        guard isViewLoaded else { return nil }
        return view as? MyView
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = MyView()
    }
}

