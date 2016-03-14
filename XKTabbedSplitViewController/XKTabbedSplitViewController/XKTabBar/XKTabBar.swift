//
//  XKTabBar.swift
//  XKTabbedSplitViewController
//
//  Created by DengYikai on 12/7/15.
//  Copyright © 2015 Safaride. All rights reserved.
//

import UIKit

protocol XKTabBarDelegate: NSObjectProtocol {
    func tabBarAndSelectedViewController(tabBar: XKTabBar, vc: UIViewController)
}

let iOS_7 = Double(UIDevice.currentDevice().systemVersion) >= 7.0

let tabBarWidth:Int = 96
let tabItemHeight:Int = 106

class XKTabBar: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var backgroundImage:UIImage?
    var tabsButtons:Array<XKTabBarItem>?
    var delegate:XKTabBarDelegate?
    var selectedTabIndex:Int?
    
    private var tabsButtonsHeight:Int?
    private var selectedTab:NSIndexPath?
    
    private var tabsTable:UITableView?
    
    private let tabsButtonsFrame:CGRect?
    
    init() {
        super.init(nibName: "", bundle: nil)
        
        self.view.clipsToBounds = true
        self.view.backgroundColor = UIColor(red: randomColorValue(), green: randomColorValue(), blue: randomColorValue(), alpha: 1)
        
        tabsButtonsHeight = 0;
        tabsButtonsFrame = CGRect(x: 0, y: 0, width: CGFloat(tabBarWidth), height: CGFloat(tabsButtonsHeight!));
    }
    
    private func tabsInit(tabs:[XKTabBarItem]) {
    
        var tmpItems:Array<XKTabBarItem>?
        
        for obj in tabs {
            
            tabsButtonsHeight! += tabItemHeight
            
            tmpItems!.append(obj)
        }
        
        tabsButtons = tmpItems;
        
        tabsTable = UITableView(frame: tabsButtonsFrame!, style: UITableViewStyle.Plain)
        tabsTable!.scrollEnabled = true
        tabsTable!.dataSource = self
        tabsTable!.delegate = self
        
        tabsTable!.separatorStyle = UITableViewCellSeparatorStyle.None
        tabsTable!.backgroundColor = UIColor.clearColor()
        tabsTable!.tableFooterView = UIView()
        
        if (tabsButtons!.count > 0) {
            
            let firstTab = NSIndexPath(forRow: 0, inSection: 0)
            selectedTabIndex = firstTab.row
            tabsTable!.selectRowAtIndexPath(firstTab, animated: true, scrollPosition: UITableViewScrollPosition.None)
//            tableView(tabsTable!, didSelectRowAtIndexPath: firstTab)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func randomColorValue() -> CGFloat {
        
        return CGFloat(Double(arc4random_uniform(255)) / 255)
    }
    
    //MARK:
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tabsButtons!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return CGFloat(tabItemHeight)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:XKTabBarItemCell? = tableView.dequeueReusableCellWithIdentifier("tabbar") as? XKTabBarItemCell
        
        if (cell == nil) {
            cell = XKTabBarItemCell(style: UITableViewCellStyle.Default, reuseIdentifier: "tabbar")
        }
        
        let tabItem:XKTabBarItem = tabsButtons![indexPath.row]
        cell!.viewController = tabItem.viewController;
        cell!.isFirstCell = indexPath.row == 0
        cell!.aSelectedColor = tabItem.viewController!.view.backgroundColor
        cell!.iconView!.image = tabItem.image
        cell!.aSelectedImage = tabItem.selectedImage
        cell!.aImage = tabItem.image
        cell!.titleLabel!.font = UIFont.systemFontOfSize(17)
        cell!.titleLabel!.text = tabItem.title
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (!(selectedTab!.isEqual(<#T##object: AnyObject?##AnyObject?#>)))
    }
}