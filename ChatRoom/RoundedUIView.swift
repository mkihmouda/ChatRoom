//
//  RoundedUIView.swift
//  YaTranslator
//
//  Created by Mac on 12/2/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedUIView: UIView {
    

// MARK: circle view methods

    @IBInspectable var roundedView : Bool = false {
        
        didSet{
            
            makeRounded()
            
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        makeRounded()
        
    }
    
    
    func makeRounded(){
        
        if (roundedView){
            
            self.layer.cornerRadius = 20.0
            self.clipsToBounds = true
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.gray.cgColor
        }
        
    }

}
