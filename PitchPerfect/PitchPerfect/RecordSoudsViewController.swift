//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by JL on 4/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //AudioRecord Global varariable
    var audioRecorder: AVAudioRecorder!

    //Events from our code to UI
    @IBOutlet weak var recordingLabel: UILabel!
    
    //addding a recoding functionalities from our codes to UI
    @IBOutlet weak var recordButton: UIButton!
    
    //Event from code to UI to stopped recording
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    //happend before view is loaded
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) //after ui is loaded
        
    }

    //to record event from UI to our code
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        //Constant String Array for the directory path
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        //Constant for our Recording sound names, file to save our recordings.
        let recordingName = "recordedVoice.wav"
        //Constant for our pathway with dirPath & recordingName
        let pathArray = [dirPath, recordingName]
        //Build the Path with a back slash
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //to verify this works, let's print the file path once we start recording
        
        //Create a session Object or instance
        let session = AVAudioSession.sharedInstance()
        //Check if we can play& record using the device Speaker
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        //check if file path is availeable
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        //Let the AVAudiorecord know that our class can act as its delegate.
        //We want let the audio finished completely recording before
        //we move to the other screen
        audioRecorder.delegate = self
        
        audioRecorder.isMeteringEnabled = true
        //Get ready to record
        audioRecorder.prepareToRecord()
        //Start recording
        audioRecorder.record()
        
    }
    //Stop recording event from UI to our codes
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        //Let stop the recording when button is pressed
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(true)
    }
    //Since this class complied with the delegate protocol
    // let's the delegate inform us when the recording is done.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        //send the path where the recording is located to the segue
        //for us to play the audio on 2nd screen.
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("recording was not successful")
        }
    }
    //Prepare the segue/2nd screen to received the url
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            //Upcast the constant as playsoundViewControl
            let playSoundsVC = segue.destination as! playSoundsViewController
            //grab the sender
            let recordedAudioURL = sender as! URL
            //set the playsoundViewURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}
