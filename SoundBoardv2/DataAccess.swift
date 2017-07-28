//
//  DataAccess.swift
//  SoundBoardv2
//
//  Created by Zach Butcher on 7/28/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import Foundation
import UIKit

class DataAccess {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recordings :[Recording] = []
    
    
    func DataAccess(){

    
    }
    
    func getRecordings() -> [Recording]{
        do {
        return try context.fetch(Recording.fetchRequest()) as! [Recording]
        }catch{
            
        }
        return recordings
    }
    
    func addRecording(newAudio:Any, recordingName: String){
        
        let newRecording = Recording(context: context)
        newRecording.name = recordingName
        //newRecording.recording = Audio(imagePreview.image!)! as NSData
    
    
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


}
