//
//  RoundedUIButton.swift
//  YaTranslator
//
//  Created by Mac on 11/29/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedUIButton: UIButton {
  
    
// MARK: circle button methods

    @IBInspectable var circleButton : Bool = false {
        
        didSet{
            
            makeCircle()
            
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        makeCircle()
        
    }
    
    
    func makeCircle(){
        
        if (circleButton){
            
            self.layer.cornerRadius = self.frame.width/2
            self.clipsToBounds = true
            
        }
        
    }
  
}
