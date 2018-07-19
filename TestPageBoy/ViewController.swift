//
//  ViewController.swift
//  TestPageBoy
//
//  Created by Natthakit Susanthitanon on 19/7/18.
//  Copyright © 2018 NSmag. All rights reserved.
//

import UIKit
import Pageboy
import Dispatch

class ViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {

    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pageboy"
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        
        vc1.view.backgroundColor = .red
        vc2.view.backgroundColor = .yellow
        vc3.view.backgroundColor = .green
        
        viewControllers = [vc1, vc2, vc3]
        
        self.dataSource = self
        self.delegate = self
        self.isInfiniteScrollEnabled = true
        self.autoScroller.restartsOnScrollEnd = true
        self.autoScroller.enable(withIntermissionDuration: .custom(duration: 2))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            if let navigationController = self.navigationController {
                navigationController.pushViewController(PushedViewController(), animated: true)
            }
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
