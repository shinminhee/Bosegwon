//
//  MyPageViewController.swift
//  Bosegwon
//
//  Created by 신민희 on 2021/05/27.
//

import UIKit
import Firebase
import GoogleSignIn

class MyPageViewController: UIViewController {
    
    let googleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

extension MyPageViewController {
    final private func setUI() {
        setBasic()
        setLayout()
    }
    final private func setBasic() {
        googleButton.backgroundColor = .red
        
    }
    final private func setLayout() {
        view.addSubview(googleButton)
        googleButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
    }
}
