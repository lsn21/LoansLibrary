//
//  LoanViewController.swift
//  LoansHelpers
//
//  Created by Siarhei Lukyanau on 31.10.25.
//

import UIKit

public class CustomTabBar: UITabBar {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttons = self.subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
        buttons.forEach { button in
            let offset: CGFloat = iPad ? 4 : 0  // Пример смещения
            let height = self.frame.height * 0.5 + offset
            button.center.y = height
        }
    }
}

open class LoanViewController: UIViewController {

    open var tabBar = CustomTabBar()
    open var saveTabBarController: UITabBarController?

    open weak var delegate: UITabBarDelegate?
    
    open var heightCorrect: CGFloat = 16
    open var heightCorrectPad: CGFloat = -16
    
    open var xCorrect: CGFloat = 0

    open var yCorrect: CGFloat = 0
    open var yCorrectPad: CGFloat = 0

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let height = tabBar.frame.size.height
        var newTabBarHeight = height + heightCorrect
        var newFrame = tabBar.frame
        if iPad {
            newTabBarHeight = height + heightCorrectPad
        }
        newFrame.size.height = newTabBarHeight
        newFrame.size.width = widthScreen + xCorrect
        
        let x = tabBar.frame.origin.x
        let newTabBarX = x - xCorrect / 2
        let y = tabBar.frame.origin.y
        var newTabBarY = y + yCorrect
        if iPad {
            newTabBarY = y + yCorrectPad
        }
        newFrame.origin.x = newTabBarX
        newFrame.origin.y = newTabBarY
        tabBar.frame = newFrame
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = .clear
        appearance.backgroundImage = UIImage(named: "tabbar_back")
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

extension LoanViewController: UITabBarDelegate {
    
    open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tag = item.tag
        let tabBarController = saveTabBarController
        tabBarController?.selectedIndex = tag
        if let nv = self.navigationController {
            nv.popToRootViewController(animated: false)
        }
    }
}
