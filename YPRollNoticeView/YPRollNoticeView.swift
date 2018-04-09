//
//  YPRollNoticeView.swift
//  YPRollNoticeView
//
//  Created by Imp on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

import UIKit

class YPRollNoticeView: UIView {
    var labelOne = UILabel()
    var labelTwo = UILabel()
    var timer: Timer?
    var index = 1
    var withOne = false
    var rollArray: [String]? {
        didSet {
            refreshData()
        }
    }
    var clickBlock: ((_ idnex: Int)->())?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = true
        labelOne.isUserInteractionEnabled = true
        labelOne.font = UIFont.systemFont(ofSize: 13)
        labelOne.textColor = .black
        labelOne.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapLabelAction(tap:))))
        labelTwo.isUserInteractionEnabled = true
        labelTwo.font = UIFont.systemFont(ofSize: 13)
        labelTwo.textColor = .black
        labelTwo.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapLabelAction(tap:))))
        self.addSubview(labelOne)
        self.addSubview(labelTwo)
    }

    @objc func tapLabelAction(tap: UITapGestureRecognizer) {
        var clickIndex = index
        if clickIndex == 0 {
            clickIndex = rollArray!.count
        }
        clickBlock?(clickIndex - 1)
    }

    func refreshData() {
        withOne = false
        index = 1
        if rollArray?.count == 0 {
            return
        }
        timer?.invalidate()
        timer = nil
        if rollArray?.count == 1 {
            labelOne.text = rollArray?.first
            labelOne.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        } else {
            labelOne.text = rollArray?.first
            labelOne.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            labelTwo.text = rollArray![index]
            labelTwo.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
            timer = Timer.init(timeInterval: 3, target: self, selector: #selector(rollAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .commonModes)
        }
    }

    @objc func rollAction() {
        index += 1
        if self.index > self.rollArray!.count - 1 {
            self.index = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            if self.withOne {
                self.labelOne.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                self.labelTwo.frame = CGRect.init(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
            } else {
                self.labelOne.frame = CGRect.init(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                self.labelTwo.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            }
        }) { (finish) in
            self.withOne = !self.withOne
            if self.labelOne.frame.origin.y == -self.frame.size.height {
                self.labelOne.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                self.labelOne.text = self.rollArray![self.index]
            }
            if self.labelTwo.frame.origin.y == -self.frame.size.height {
                self.labelTwo.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                self.labelTwo.text = self.rollArray![self.index]
            }
        }
    }
}
