//
//  ViewController.swift
//  CommonFontOperations
//
//  Created by 何柱君 on 2022/5/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let subView = UIView()
        view.addSubview(subView)
        subView.backgroundColor = .blue
        
        subView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }


}

