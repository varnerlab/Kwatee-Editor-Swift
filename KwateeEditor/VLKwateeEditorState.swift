//
//  VLKwateeEditorState.swift
//  KwateeEditor
//
//  Created by Jeffrey Varner on 12/22/15.
//  Copyright © 2015 Varnerlab. All rights reserved.
//

import Foundation

// setup memento ...
typealias VLKwateeMemento = Dictionary<String, String>
let VLKwateeMementoKeyServerPath = "org.varnerlab.kwatee.serverpath"
let VLKwateeMementoKeyModelTypeDisplayText = "org.varnerlab.kwatee.modeltype.displaytext"
let VLKwateeMementoKeyModelTypeInputHandler = "org.varnerlab.kwatee.modeltype.inputhandler"
let VLKwateeMementoKeyModelTypeOutputHandler = "org.varnerlab.kwatee.modeltype.outputhandler"

class VLKwateeEditorState {
    
    // Instance variables -
    private var server_path: String = ""
    private var display_text: String = ""
    private var input_handler: String = ""
    private var output_handler: String = ""
    
    func toMemento() -> VLKwateeMemento {
        
        // build the memento object -
        var memento_object = VLKwateeMemento()
        
        return memento_object
    }
    
    func restoreFromMemento(memento: VLKwateeMemento) {
        
        // grab the state from the memento object -
        server_path = memento[VLKwateeMementoKeyServerPath]!
        display_text = memento[VLKwateeMementoKeyModelTypeDisplayText]!
        input_handler = memento[VLKwateeMementoKeyModelTypeInputHandler]!
        output_handler = memento[VLKwateeMementoKeyModelTypeOutputHandler]!
    }
}