//
//  BlureView.swift
//  YaTranslator
//
//  Created by Mac on 12/5/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class BlureView: UIView {

    override func awakeFromNib() {
        
        self.addBlureEffects()
    }
    
    
    func addBlureEffects(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(origin: CGPoint(x: 0 ,y : 0 ),  size: CGSize(width: self.frame.size.width , height: self.frame.size.height))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.75
        self.addSubview(blurEffectView)
        self.sendSubview(toBack: blurEffectView)
        
    }
}
