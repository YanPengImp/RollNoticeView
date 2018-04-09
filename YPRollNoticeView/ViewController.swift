//
//  ViewController.swift
//  YPRollNoticeView
//
//  Created by Imp on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rollView: YPRollNoticeView?

    override func viewDidLoad() {
        super.viewDidLoad()

        rollView = YPRollNoticeView.init(frame: CGRect.init(x: 30, y: 100, width: 200, height: 30))
        rollView!.backgroundColor = .red
        rollView!.clickBlock = { index in
            print("点击了\(index)")
        }
        self.view.addSubview(rollView!)
        rollView!.rollArray = ["测试第一条","测试第二条","测试第三条","测试第四条","测试第五条"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

