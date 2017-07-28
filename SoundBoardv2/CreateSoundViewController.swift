//
//  CreateSoundViewController.swift
//  SoundBoardv2
//
//  Created by Zach Butcher on 7/27/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit
import AVFoundation

class CreateSoundViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!

    var audioRecorder :AVAudioRecorder?
    var audioPlayer :AVAudioPlayer?
    var audioFilename : URL?
    var dataAccess = DataAccess()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        playButton.isEnabled = false
        addButton.isEnabled = false
        
        setuprecorder()
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func setuprecorder () {
        
        
        do{
            //create url for audio file
            
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            audioFilename = documentsDirectory.appendingPathComponent("recording.m4a")
            print(audioFilename!)
            /*
             
             let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
             let pathComponents = [basePath: "audio.m4a"]
             let audioURL = NSURL.fileURL(withPath: pathComponents)!
             
             */
            //create audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //create settings for audio recorder
            var settings :[String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            //create audio recorder object
            try audioRecorder = AVAudioRecorder(url: audioFilename!, settings: settings)
            
            
        }catch {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            audioRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
        }else{
            audioRecorder?.record()
            
            recordButton.setTitle("Stop", for: .normal)
        }
        
        playButton.isEnabled = true
    }
    
    @IBAction func playTapped(_ sender: Any) {
        playAudio()
        
    }

    @IBAction func addTapped(_ sender: Any) {
        
    }
    
    @IBAction func textfieldEdited(_ sender: Any) {
        addButton.isEnabled = true
    }

    
    func playAudio() {
        
        do{
        try audioPlayer = AVAudioPlayer(contentsOf: audioFilename!)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
        }catch{
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
