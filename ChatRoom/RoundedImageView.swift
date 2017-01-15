//
//  RoundedImageView.swift
//  YaTranslator
//
//  Created by Mac on 12/7/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    
    @IBInspectable var circleImage : Bool = false {
        
        didSet{
            
            makeRounded()
            
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        makeRounded()
        
    }
    
    
    override func makeRounded(){
        
        if (circleImage){
            
            self.layer.cornerRadius = self.frame.width/2
            self.clipsToBounds = true
            
        }
        
    }


}
