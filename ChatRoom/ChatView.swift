//
//  ChatView.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class ChatView: UIView, UITextViewDelegate  {
    
    @IBOutlet var textView: UITextView! // chat text view
    @IBOutlet var roundedView: RoundedUIView! // rounded view
    
    
    var significantChange : Bool = false // significant change falg
    var mainVC : ChatMessagesVC? // parent VC
    
    var textHeight : CGFloat = 0.0 // text height - to edit text view height for significant change in height
    var keyboardHeigh : CGFloat = 0.0 // keyboard height
    
    var btnSound : AVAudioPlayer?
    
    
    
    override func awakeFromNib() {
        
        
        self.textView.delegate = self
        
    }
 
    
    
    
    // MARK: keyboard methods and notifications
    
    
    func keyboardMethods(){
        
        // Keyboard show and hide notifications
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatView.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Gesture tap definition
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        self.mainVC?.mainView.addGestureRecognizer(tapGesture)
        
    }
    
    func tapAction(_ sender: UITapGestureRecognizer) {
        
        self.textView.endEditing(true)
        mainVC?.listScrollModel.updateScrollWithHiddenKeyboard()  // reset scroll view frame size
        endEditing()
        
    }
    
    
    // MARK: Keyboard methods
    
    func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeigh = keyboardSize.height
            
            UIView.animate(withDuration: 1.5 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                self.frame.origin.y =  screenHeight - self.keyboardHeigh - self.frame.size.height // show textview upper keyboard
                
            }, completion: nil)
            
            
            mainVC?.listScrollModel.updateScrollWithShownKeyboard(keyboardHeigh: keyboardHeigh) // update scroll view according to keyboard size
            
        }
        
    }
    
    
    func keyboardWillHide(notification: Notification) {
        
        mainVC?.listScrollModel.updateScrollWithHiddenKeyboard()  // reset scroll view frame size
        endEditing()
        
    }
    
    
    func endEditing(){
        
        self.textView.text = ""
        self.keyboardHeigh  = 0.0
        
        significantChange = true
        updateTextViewFrame()
        
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" { // return keytapped
            
            self.textView.endEditing(true)
            
            return false
        }
        
        updateTextViewFrame()
        return true
    }
    
    
    
    // MARK: update TextView and frames size
    
    func updateTextViewFrame(){
        
        let contentSize = self.textView.sizeThatFits(self.textView.bounds.size) // fit textview size according to content
        
        if (contentSize.height != textHeight || significantChange){ // update only if new line or significant Change
            
            updateHeight(contentSize: contentSize) // update with new height
            
            UIView.animate(withDuration: 0.5 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                self.frame.origin.y =  screenHeight - self.keyboardHeigh - self.frame.size.height // animate TextView to top
                self.significantChange = false
                
            }, completion: nil)
        }
    }
    
    
    func updateHeight(contentSize : CGSize){
        
        let newHeight = contentSize.height + roundedPadding * 2 + chatTextViewPadding * 2
        textHeight = contentSize.height
        
        self.frame.size.height =  newHeight
        self.roundedView.frame.size.height =  newHeight
        
        self.textView.frame.size.height =  textHeight
        self.textView.contentSize.height =  textHeight
        
    }
    
    // MARK : addMessagesAutomatically - Previous messages
    
    func addMessagesAutomatically(text : String,  image:  String){
 
        postMessage(text: text, automatic: true,senderURL: image)
 
    }
    
    // MARK: send message button action
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        
        mainVC?.postAPI(text: textView.text)

    }
    
    
    func postMessage(text : String, automatic: Bool, senderURL : String?){
    
        let messageView : MessageView =  Bundle.instantiateNib(owner: nil)
        
        messageView.senderType = messageDirection(url: senderURL!)
        messageView.ImageURL = senderURL
        messageView.setMessageText(text: text)
        mainVC?.listScrollModel.addMessage(view: messageView, keyboardHeigh: keyboardHeigh)
        
        if !automatic{
        
            postSendMessage() // post submitting message

        }
    
    }
    
    
    func postSendMessage(){
        
        playSiriSound(fileName: "message")
        textView.text = "" // clear textView
        updateTextViewFrame()
    }
    
    
    
    
    // MARK: message number
    
    
    func messageDirection(url: String) -> MessageView.sendingType{
        
        if url == UserDefaults.standard.value(forKey: "user_image") as! String {
        
            return .sender
   
        }
        
        return .receiver
        
    }
    
    
    
    //    MARK: SoundPlayer Functions
    
    func  playSiriSound( fileName : String){
        
        let soundClass = SoundPlayer.init(trackName: fileName)
        btnSound = soundClass.btnSound
        playSound()
        
    }
    
    func playSound(){
        
        if (btnSound!.isPlaying){
            
            btnSound!.stop()
            
        }else{
            
            btnSound!.play()
            
        }
        
    }
    
}


extension Int {
    
    var messageDirection: Int { return (self - 1) % 2 }
    
    
}
