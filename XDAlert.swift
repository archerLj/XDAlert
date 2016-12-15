//
//  XDAlert.swift
//  XDTest
//
//  Created by git on 2016/12/15.
//  Copyright © 2016年 git. All rights reserved.
//

import UIKit
import SnapKit


protocol XDAlertDelegate {
    func xdAlertCancelButtonClicked(xdAlert: XDAlert)
    func xdAlertConfirmButtonClicked(xdAlert: XDAlert)
}

class XDAlert: UIView {
    //MARK: Varibles
    var delegate: XDAlertDelegate?
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: self.bounds)
        bgView.backgroundColor = UIColor.clear
        return bgView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 5.0
        return containerView
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        return messageLabel
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton()
        confirmBtn.backgroundColor = UIColor(white: 0, alpha: 0.7)
        confirmBtn.addTarget(self, action: #selector(self.confirmBtnAction(_:)), for: .touchUpInside)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.layer.cornerRadius = 5.0
        return confirmBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnAction(_:)), for: .touchUpInside)
        return cancelBtn
    }()
    
    
    //MARK: functions
    func cancelBtnAction(_ sender: UIButton) {
        self.delegate?.xdAlertCancelButtonClicked(xdAlert: self)
        self.removeAnimate()
    }
    
    func confirmBtnAction(_ sender: UIButton) {
        self.delegate?.xdAlertConfirmButtonClicked(xdAlert: self)
        self.removeAnimate()
    }
    
    func removeAnimate() { // 消失时候的动画效果
        let offsetY = self.bounds.size.height/2 + self.containerView.bounds.size.height/2 + 50.0
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.bgView.transform = CGAffineTransform.init(translationX: 0, y: -offsetY)
        }, completion: { finished in
            self.removeFromSuperview()
        })
    }
    
    
    func show(_ message: String, confirmBtnTitle confirmTitle: String?) {
        
        self.messageLabel.text = message
        
        
        let window = UIApplication.shared.windows.last
        window?.addSubview(self)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.containerView)
        self.bgView.addSubview(self.cancelBtn)
        self.containerView.addSubview(self.messageLabel)
        
        
        self.containerView.snp.makeConstraints({ (make) in
            make.width.equalTo(300.0)
            make.height.equalTo(200.0)
            make.center.equalToSuperview()
        })
        
        self.messageLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.bottom.equalToSuperview().offset(-50.0)
        })
        
        if let _ = confirmTitle { // 如果有确定按钮，则关闭按钮在右上角, 确定按钮在底部
            self.cancelBtn.setImage(UIImage(named: "right_corner_btn"), for: .normal)
            self.confirmBtn.setTitle(confirmTitle, for: .normal)
            self.containerView.addSubview(self.confirmBtn)
            self.cancelBtn.snp.makeConstraints({ (make) in
                make.top.equalTo(self.containerView).offset(-32.0)
                make.right.equalTo(self.containerView).offset(32.0)
                make.width.height.equalTo(64.0)
            })
            
            self.confirmBtn.snp.makeConstraints({ (make) in
                make.width.equalTo(100.0)
                make.height.equalTo(44.0)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-5.0)
            })
            
        } else {// 如果没有确定按钮，则关闭按钮在底部
            cancelBtn.setImage(UIImage(named: "bottom_btn"), for: .normal)
            self.cancelBtn.snp.makeConstraints({ (make) in
                make.width.height.equalTo(64.0)
                make.centerX.equalTo(self.containerView)
                make.bottom.equalTo(self.containerView).offset(32.0)
            })
        }
        
        // 动画效果
        let offsetY = self.bounds.size.height/2 + self.containerView.bounds.size.height/2
        self.bgView.transform = CGAffineTransform.init(translationX: 0, y: -offsetY)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0.6)
            self.bgView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}
