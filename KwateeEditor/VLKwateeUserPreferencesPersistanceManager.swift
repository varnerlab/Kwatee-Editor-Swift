//
//  VLKwateeUserPreferencesPersistanceManager.swift
//  KwateeEditor
//
//  Created by Jeffrey Varner on 12/23/15.
//  Copyright © 2015 Varnerlab. All rights reserved.
//

import Foundation

class VLKwateeUserPreferencesPersistanceManager {
    
    // class/instance variables -
    static let sharedInstance = VLKwateeUserPreferencesPersistanceManager()
    
    // private constructor -
    private init() {
    }
    
    
    func saveEditorState(memento: VLKwateeMemento, keyName: String = VLKwateeMementoKeyEditorState) {
        
        // Grab the defaults - and dump to disk
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(memento, forKey: keyName)
        defaults.synchronize()
    }
    
    
    func restorePreviousEditorState(keyName keyName: String = VLKwateeMementoKeyEditorState) -> VLKwateeMemento {
        
        // grab the defaults -
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // grab the memento at the state keyword -
        if let memento_object =  defaults.objectForKey(keyName) as? VLKwateeMemento {
            return memento_object
        }
        else {
            return VLKwateeMemento()
        }
    }
}
