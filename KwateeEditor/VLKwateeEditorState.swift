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
let VLKwateeMementoKeyEditorState = "org.varnerlab.kwatee.editorstate"
let VLKwateeMementoKeyServerPath = "org.varnerlab.kwatee.serverpath"
let VLKwateeMementoKeyModelTypeSelectedIndex = "org.varnerlab.kwatee.modeltype.selectedindex"
let VLKwateeMementoKeyModelTypeDisplayText = "org.varnerlab.kwatee.modeltype.displaytext"
let VLKwateeMementoKeyModelTypeInputHandler = "org.varnerlab.kwatee.modeltype.inputhandler"
let VLKwateeMementoKeyModelTypeOutputHandler = "org.varnerlab.kwatee.modeltype.outputhandler"

class VLKwateeEditorState {
    
    // Instance variables -
    var selected_index: String?
    var server_path: String?
    var display_text: String?
    var input_handler: String?
    var output_handler: String?
    
    func toMemento() -> VLKwateeMemento {
        
        // build the memento object -
        var memento_object = VLKwateeMemento()
        
        // add the data to the memento object -
        if let value = selected_index {
            memento_object[VLKwateeMementoKeyModelTypeSelectedIndex] = value
        }
        
        // server path -
        if let value = server_path {
            memento_object[VLKwateeMementoKeyServerPath] = value
        }
        
        // display text -
        if let value = display_text {
            memento_object[VLKwateeMementoKeyModelTypeDisplayText] = value
        }
        
        // input handler -
        if let value = input_handler {
            memento_object[VLKwateeMementoKeyModelTypeInputHandler] = value
        }
        
        // output handler -
        if let value = output_handler {
            memento_object[VLKwateeMementoKeyModelTypeOutputHandler] = value
        }
        
        // return the object -
        return memento_object
    }
    
    func restoreFromMemento(memento: VLKwateeMemento) {
        
        // grab the state from the memento object -
        
        // server path -
        if let value = memento[VLKwateeMementoKeyServerPath] {
            server_path = value
        }
        
        // display text -
        if let value = memento[VLKwateeMementoKeyModelTypeDisplayText] {
            display_text = value
        }
        
        // input handler -
        if let value = memento[VLKwateeMementoKeyModelTypeInputHandler] {
            input_handler = value
        }
        
        // output handler -
        if let value = memento[VLKwateeMementoKeyModelTypeOutputHandler] {
            output_handler = value
        }
    }
}