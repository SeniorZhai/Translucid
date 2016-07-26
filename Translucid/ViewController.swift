//
//  ViewController.swift
//  Translucid
//
//  Created by zhai on 16/7/26.
//  Copyright © 2016年 zhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceScreenSize:CGFloat = UIScreen.mainScreen().bounds.height
        let offset: CGFloat = deviceScreenSize > 320.0 ? 50.0 : 35.0
        let star:Translucid = Translucid(frame: CGRectMake(0,offset,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)/2))
        star.font = UIFont(name: "Starjedi", size: 20)!
        star.text = "Star"
        star.backgroundImage = UIImage(named: "stars")
        
        let wars: Translucid = Translucid(frame: CGRectMake(0.0, CGRectGetHeight(self.view.frame) / 2.0 - offset, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 2.0))
        wars.font = UIFont(name: "Starjedi", size: 20)!
        wars.text = "Wars"
        wars.backgroundImage = UIImage(named: "stars")
        
        self.view.addSubview(star)
        self.view.addSubview(wars)
        
        star.animate()
        wars.animate()
    }

}

