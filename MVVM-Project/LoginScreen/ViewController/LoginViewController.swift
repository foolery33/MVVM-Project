//
//  ViewController.swift
//  MVVM-Project
//
//  Created by admin on 30.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let loginScreenView = LoginScreenView(viewModel: self.viewModel)
        view = loginScreenView
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

