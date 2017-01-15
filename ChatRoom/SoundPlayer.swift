//
//  SoundPlayer.swift
//  IPuzzle
//
//  Created by Mac on 10/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    var btnSound : AVAudioPlayer!


    init(trackName : String) {
        

        let path =  Bundle.main.path(forResource: "\(trackName)", ofType: "mp3")
        let soundURL =  NSURL(fileURLWithPath:path!)

        do{
            
            try  btnSound = AVAudioPlayer(contentsOf: soundURL as URL)
            btnSound?.prepareToPlay()
                
         
            
        } catch let err as NSError{
            
            print(err.debugDescription)
            
        }

    }
}
