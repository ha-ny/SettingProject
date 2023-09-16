//
//  TabBarViewController.swift
//  SettingProject
//
//  Created by 김하은 on 2023/09/16.
//

import UIKit
import SnapKit

class TabBarViewController: UIViewController {

    let tabbar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(tabbar.view)
        
        tabbar.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let Apple = UINavigationController(rootViewController: AppleViewController())
        Apple.tabBarItem = UITabBarItem(title: "집중 모드", image: UIImage(systemName: "apple.logo"), tag: 0)
        
        let kakao = UINavigationController(rootViewController: KakaoViewController())
        kakao.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "message.fill"), tag: 0)
        
        tabbar.viewControllers = [Apple, kakao]
    }
}
