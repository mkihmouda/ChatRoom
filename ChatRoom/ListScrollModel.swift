//
//  ListScrollModel.swift
//  YaTranslator
//
//  Created by Mac on 12/2/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit


class ListScrollModel{
    
    var scrollView : UIScrollView! // scroll view
    var scrollViewAccumulativeHeight : CGFloat = 0.0 // Acc. Height
     
    
    init(scrollView : UIScrollView) {
        
        self.scrollView = scrollView
        scrollViewAccumulativeHeight = scrollViewPaddingHeight // inital padding
        
    }
    
  
    
    
    // MARK: add Sender and Receiver to list Scroll
    
    
    func addMessage(view : UIView, keyboardHeigh : CGFloat){
        
        view.frame.origin.y = scrollViewAccumulativeHeight
        self.scrollView.addSubview(view)
        
        
        scrollViewAccumulativeHeight = scrollViewAccumulativeHeight + view.frame.size.height + 5 // update Acc. height
        self.updateScrollContentHeight()
        
    }
    
    
    
    // MARK: update after keyboard shown and hidden
    
    
    func updateScrollWithShownKeyboard(keyboardHeigh : CGFloat){
        
        
        UIView.animate(withDuration: 1.7 , delay: 0.0, options: [.curveEaseOut], animations: {
            
            
            let newHieght = self.caluclateNewHeight(keyboardHeigh : keyboardHeigh)
            
            self.scrollView.frame.size.height = newHieght
            self.scrollView.contentSize.height = newHieght > self.scrollViewAccumulativeHeight ? newHieght :  self.scrollViewAccumulativeHeight
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            
            
        }, completion: nil)
        
    }
    
    
    
    func updateScrollWithHiddenKeyboard(){
        
        
        UIView.animate(withDuration: 1.7 , delay: 0.0, options: [.curveEaseOut], animations: {
            
            self.scrollView.frame.size.height = screenHeight - 90 - 60
            self.scrollView.contentSize.height = self.scrollViewAccumulativeHeight
            
        }, completion: nil)
        
        
    }
    
    
    func automaticUpdateScrollWithHiddenKeyboard(){
  
            self.scrollView.frame.size.height = screenHeight - 90 - 60
            self.scrollView.contentSize.height = self.scrollViewAccumulativeHeight
   
    }
    
    
    
    
    func caluclateNewHeight(keyboardHeigh : CGFloat) -> CGFloat {
        
        return screenHeight - 60  - 50 - self.scrollView.frame.size.height + keyboardHeigh - chatViewHeight
        
    }
    
    
    
    // MARK: update Scroll view data
    
    
    func updateScrollContentHeight(){

        if (scrollViewAccumulativeHeight >  scrollView.contentSize.height){
            
            // update content size
            
            scrollView.contentSize.height = scrollViewAccumulativeHeight
            
            UIView.animate(withDuration: 0.7 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                // scroll to bottom
                
                self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                
            }, completion: nil)
        }
    }
    
    
    
}
