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

class ViewController: UITableViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    
    var viewControllers: [UIViewController] = []
    private let cellId = "cell"
    
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
        
        tableView.register(PageBoyTableViewCell.self, forCellReuseIdentifier: cellId)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            if let navigationController = self.navigationController {
                navigationController.pushViewController(PushedViewController(), animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PageBoyTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PageBoyTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PageBoyTableViewCell

        cell.setPageViewController(dataSource: self, delegate: self, indexPath: indexPath)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}

class IndexPathPageboyViewController: PageboyViewController {
    
    var indexPath: IndexPath!
    
}

class PageBoyTableViewCell: UITableViewCell {
    
    var pageViewController = IndexPathPageboyViewController()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(pageViewController.view)
        
        pageViewController.isInfiniteScrollEnabled = true
        pageViewController.autoScroller.restartsOnScrollEnd = true
        pageViewController.autoScroller.enable(withIntermissionDuration: .custom(duration: 2))
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final override func layoutSubviews() {
        super.layoutSubviews()
        
        guard pageViewController.view.frame != contentView.bounds else {
            return
        }
        
        pageViewController.view.frame = contentView.bounds
    }
    
    final func setPageViewController(dataSource: PageboyViewControllerDataSource, delegate: PageboyViewControllerDelegate, indexPath: IndexPath) {
        pageViewController.indexPath = indexPath
        
        if pageViewController.dataSource == nil {
            pageViewController.dataSource = dataSource
        }
        
        if pageViewController.delegate == nil {
            pageViewController.delegate = delegate
        }
    }
    
}
