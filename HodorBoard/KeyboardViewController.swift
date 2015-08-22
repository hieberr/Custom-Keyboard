//
//  KeyboardViewController.swift
//  HodorBoard
//
//  Created by floatingpoint on 8/20/15.
//  Copyright © 2015 HologramPacific. All rights reserved.
//

import UIKit
import AVFoundation

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var player: AVAudioPlayer = AVAudioPlayer()
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }



  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load hodor audio
        let audioPath = NSBundle.mainBundle().pathForResource("Hodor", ofType: "wav")!
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            player.prepareToPlay()
        } catch {
            print("Error initializing AVAudioPlayer)")
        }
        

        //nextKeyboardButton
        self.nextKeyboardButton = UIButton(type: .System)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
        
        
        //hodor button
        let button = UIButton(type: .System) as UIButton
        button.frame = CGRectMake(150, 40, 100,120)
        
        
        button.setBackgroundImage(UIImage(named: "hodorHeadShot.png"), forState: .Normal)
        
        button.setTitle(NSLocalizedString("Hodor", comment: "Hodor Button"), forState: .Normal)

        
        button.addTarget(self, action: "didPressButton", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)


    }
    
    func quickFade(){
        
    }
    
    func didPressButton(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("Hodor")

        player.currentTime = 0
        let time = CMTime(value: 0 as Int64, timescale: 1 as Int32)
        let time2 = CMTime(value: 0 as Int64, timescale: 1 as Int32, flags: CMTimeFlags.Indefinite, epoch: 0 as Int64)
        
        
        //let audioPath = NSBundle.mainBundle().pathForResource("Hodor", ofType: "wav")!
        /*
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
        } catch {
            print("Error initializing AVAudioPlayer)")
        }
        */
        
        
        //var playerItem: AVPlayerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: audioPath))
        //var playerItemTrack: AVPlayerItemTrack = AVPlayerItemTrack()
        
        //add the ItemTrack to the Item
        //playerItem.tracks.append(playerItemTrack)

        /*
        // Create the audio mix input parameters object.
        var mutableAudioMix: AVMutableAudioMix = AVMutableAudioMix()
        // Set the volume ramp to slowly fade the audio out over the duration of the composition.
        var mixParameters: AVMutableAudioMixInputParameters = AVMutableAudioMixInputParameters()
        var timeRange: CMTimeRange = CMTimeRangeMake(kCMTimeZero, CMTime(seconds: 1, preferredTimescale: <#T##CMTimeScale#>))
        mixParameters.setVolumeRampFromStartVolume(1.0, toEndVolume: 0.0, timeRange: timeRange)

        
        // Attach the input parameters to the audio mix.
        mutableAudioMix.inputParameters.append(mixParameters)
        
        player.
        */
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
