//
//  UIChallengeTabBarController.swift
//  Challenge
//
//  Created by ice on 2020/3/11.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class UIChallengeTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.black // 设置tabBar的颜色
        let controllers = [UIHomePageViewController(titles: ["热门","最新"], vcs: [UIHotViewController(),UINewestViewController()], pageStyle: .navigationBarSegment),UIPublishViewController(),UIMineViewController()]
        let titles = ["首页","","我的"]
        let images = ["home","photo_verybig","me"]
        let selectImages = ["home_1","photo_verybig","me_1"]
        self.tabBar.shadowImage = UIImage(named: "transparent")
        self.tabBar.backgroundImage = UIImage(named: "background_dark")
        addChildViewController(childControllers: controllers, titles: titles, images: images, selectedImages: selectImages)
        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        //MARK:- 弹出视图
        self.didHijackHandler = { tabbarController, viewController, index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let alertController = UIPublishViewController()
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - 添加子视图
    func addChildViewController(childControllers: [UIViewController], titles: [String], images: [String], selectedImages: [String]) {
        for index in 0...2 {
            let childController : UIViewController = childControllers[index]
            if index == 1 {
                childController.tabBarItem = ESTabBarItem.init(Eric_IrregularityContentView(), title: titles[index], image: UIImage(named: images[index]), selectedImage: UIImage(named: selectedImages[index]))
            }else {
                childController.tabBarItem = ESTabBarItem.init(Eric_IrregularityBasicContentView(), title: titles[index], image: UIImage(named: images[index]), selectedImage: UIImage(named: selectedImages[index]))
            }
            childController.title = titles[index]
            addChild(UIChallengeNavigationController(rootViewController: childController))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
