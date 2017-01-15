//
//  MaterialUIView.swift
//  CoreDataFirstApp
//
//  Created by Mac on 10/30/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

private var _materialDesign = false

 extension UIView {

    @IBInspectable var materialDesign : Bool {
    
        get{
            
            return _materialDesign
            
            
        }set{
            
            _materialDesign = newValue
            
            self.updateUIView()
            
        
        }
    
    
    }
    
    func updateUIView(){
    
        if  _materialDesign {
            
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 3.0
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 3.0
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowColor = UIColor.gray.cgColor
            
        }else{
            
            self.layer.cornerRadius = 0.0
            self.layer.shadowOpacity = 0.0
            self.layer.shadowRadius = 0.0
            self.layer.shadowColor = UIColor.clear.cgColor
            
            
        }
  
    }
    

}
