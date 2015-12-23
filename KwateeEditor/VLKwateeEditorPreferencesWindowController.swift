//
//  VLKwateeEditorPreferencesWindowController.swift
//  KwateeEditor
//
//  Created by Jeffrey Varner on 12/21/15.
//  Copyright © 2015 Varnerlab. All rights reserved.
//

import Cocoa

class VLKwateeEditorPreferencesWindowController: NSWindowController {

    // Outlets -
    @IBOutlet var myDoneButton:NSButton?
    @IBOutlet var myCancelButton:NSButton?
    @IBOutlet var myOpenServerPathButton:NSButton?
    @IBOutlet var myServerPathLabel:NSTextField?
    @IBOutlet var myModelTypePopupButton:NSPopUpButton?
    @IBOutlet var myTestServerConnectionButton:NSButton?
    @IBOutlet var myServerConnectionTestLabel:NSTextField?
    
    // data -
    private var myServerPathURL:NSURL?
    private var myEditorState:VLKwateeEditorState = VLKwateeEditorState()
    
    // managers -
    private var myPersistanceManager:VLKwateeUserPreferencesPersistanceManager = VLKwateeUserPreferencesPersistanceManager.sharedInstance
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // add items to the popup button -
        if let my_model_type_popup = myModelTypePopupButton {
         
            // get the array of model types -
            if let model_type_array:[ModelType] = VLKwateeConfigurationManager.sharedInstance.lookupMyModelTypesFromConfigurationTree() {
             
                for model_type:ModelType in model_type_array {
                 
                    // display text -
                    let display_text:String = model_type.display_text!
                    my_model_type_popup.addItemWithTitle(display_text)
                }
            }
        }
        
        // ok, do we have any saved preferences?
        let memento_object:VLKwateeMemento = myPersistanceManager.restorePreviousEditorState()
        myEditorState.restoreFromMemento(memento_object)
        
        // what is the server path?
        if let server_path = myEditorState.server_path {
            
            // set the server path string -
            myServerPathLabel?.stringValue = server_path
            
            // enable test -
            myTestServerConnectionButton?.enabled = true
        }
    }
    
    
    // MARK:- Action methods -
    @IBAction func myDoneButtonAction(sender:NSButton) -> Void {
        
        // save user changes, then close ...
        if let value = myServerPathLabel?.stringValue {
            
            // set the value on the state -
            myEditorState.server_path = value
        }
        
        // Dump state to persistance manager -
        myPersistanceManager.saveEditorState(myEditorState.toMemento())
        
        // close -
        self.window?.sheetParent?.endSheet(self.window!, returnCode:NSModalResponseOK)
    }
    
    @IBAction func myCancelButtonAction(sender:NSButton) -> Void {
     
        // KIA my sheet -
        self.window?.sheetParent?.endSheet(self.window!, returnCode:NSModalResponseOK)
    }
    
    @IBAction func myTestServerConnectionAction(sender:NSButton) -> Void {
    
    }
    
    @IBAction func myServerPathButtonAction(sender:NSButton) -> Void {
    
        // ok, so let's launch the open panel -
        // Method variables -
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.canChooseDirectories = true
        myFileDialog.canChooseFiles = false
        
        // completion handler -
        let myCompletionHandler = {[weak self](user_selection:Int) -> Void in
            
            // check the selection -
            if (user_selection == NSFileHandlingPanelOKButton){
                
                // get the URL -
                if let local_path_url = myFileDialog.URL {
                    
                   
                    // ok, we have the server URL -
                    // grab it (we are going to return it back to main), and then display on the path label -
                    self?.myServerPathURL = local_path_url;
                    
                    // display -
                    self?.myServerPathLabel?.stringValue = local_path_url.absoluteString
                    
                    // update the test button -
                    self?.myTestServerConnectionButton?.enabled = true
                }
            }
        }
        
        // open as sheet -
        myFileDialog.beginSheetModalForWindow(self.window!, completionHandler: myCompletionHandler);
    }
}
