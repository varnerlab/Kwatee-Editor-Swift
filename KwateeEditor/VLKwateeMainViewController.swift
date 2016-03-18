//
//  VLKwateeMainViewController.swift
//  KwateeEditor
//
//  Created by Jeffrey Varner on 12/18/15.
//  Copyright © 2015 Varnerlab. All rights reserved.
//

import Cocoa

class VLKwateeMainViewController: NSViewController {

    // Outlets -
    @IBOutlet var myPreferencesButton:NSButton?
    @IBOutlet var myUploadButton:NSButton?
    @IBOutlet var myExportButton:NSButton?
    @IBOutlet var myExecuteButton:NSButton?
    @IBOutlet var myStatusTextField:NSTextField?
    
    // Upload and export URLs
    private var myUploadURL:NSURL?
    private var myExportURL:NSURL?
    private var myPreferencesWindowViewController:VLKwateeEditorPreferencesWindowController?
    
    // load the managers -
    private let myConfigurationManager:VLKwateeConfigurationManager = VLKwateeConfigurationManager.sharedInstance
    private let myExecutionManager:VLKwateeExecutionManager = VLKwateeExecutionManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.autoresizingMask = NSAutoresizingMaskOptions.ViewNotSizable
    }
    
    // MARK:- Action methods -
    @IBAction func myPreferenceButtonAction(sender:NSButton) -> Void {
    
        // grab the preferences window controller -
        self.myPreferencesWindowViewController = VLKwateeEditorPreferencesWindowController(windowNibName:"VLKwateeEditorPreferencesWindowController");
        
        // launch the sheet -
        if let local_window = self.view.window {
            
            // completion handler -
            let myCompletionHandler = {[weak self](user_selection:NSModalResponse) -> Void in
            
                
                // kia my controller -
                self?.myPreferencesWindowViewController = nil
            }
            
            // launch -
            local_window.beginSheet((self.myPreferencesWindowViewController?.window)!, completionHandler:myCompletionHandler)
        }
    }
    
    @IBAction func myUploadButtonAction(sender:NSButton) -> Void {
        
        // Method variables -
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.canChooseDirectories = false
        myFileDialog.canCreateDirectories = false
        
        // completion handler -
        let myCompletionHandler = {[weak self](user_selection:Int) -> Void in
            
            // check the selection -
            if (user_selection == NSFileHandlingPanelOKButton){
                
                // get the URL -
                if let local_path_url = myFileDialog.URL {
                    
                    // get the URL -
                    self?.myUploadURL = local_path_url
                    
                    // activate generate button?
                    self?.activateMyExecuteButton()
                }
            }
        }
        
        // open as sheet -
        myFileDialog.beginSheetModalForWindow(self.view.window!, completionHandler: myCompletionHandler);
    }
    
    @IBAction func myExportButtonAction(sender:NSButton) -> Void {
        
        // Method variables -
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.canChooseFiles = false
        myFileDialog.canCreateDirectories = true
        myFileDialog.canChooseDirectories = true
        
        // completion handler -
        let myCompletionHandler = {[weak self](user_selection:Int) -> Void in
            
            // check the selection -
            if (user_selection == NSFileHandlingPanelOKButton){
                
                // get the URL -
                if let local_path_url = myFileDialog.URL {
                    
                    // if we have the URL, grab it for later -
                    self?.myExportURL = local_path_url
                    
                    // activate generate button?
                    self?.activateMyExecuteButton()
                }
            }
        }
        
        // open as sheet -
        myFileDialog.beginSheetModalForWindow(self.view.window!, completionHandler: myCompletionHandler);
    }
    
    @IBAction func myExecuteButtonAction(sender:NSButton) -> Void {
        
        
        
    }
    
    
    // MARK:- Helper methods -
    func activateMyExecuteButton() -> Void {
     
        // do we have the upload URL?
        if (self.myUploadURL != nil){
            
            // load image -
            if let enabled_image:NSImage = NSImage(named:"UploadIcon-Enabled") {
                
                
                // set the image on the button -
                self.myUploadButton?.image = enabled_image
                
                // Create a tool tip -
                let tool_tip = self.myUploadURL?.absoluteString
                self.myUploadButton?.toolTip = tool_tip
            }
        }
        else {
            // set the image on the button -
            self.myUploadButton?.image = NSImage(named:"UploadIcon-Disabled")
            self.myUploadButton?.toolTip = "";
        }
        
        // do we have the export URL?
        if (self.myExportURL != nil){
            
            // load image -
            if let enabled_image:NSImage = NSImage(named:"ExportPathIcon-Enabled") {
                
                // set the image on the button -
                self.myExportButton?.image = enabled_image
            }
        }
        else {
            // set the image on the button -
            self.myExportButton?.image = NSImage(named:"ExportPathIcon-Disabled")
        }
        
        
        if (self.myExportURL != nil && self.myUploadURL != nil){
            
            
            // load image -
            if let enabled_image:NSImage = NSImage(named:"ExecuteIcon-Enabled") {
                
                // set the image on the button -
                self.myExecuteButton?.image = enabled_image
                
                // enable -
                self.myExecuteButton?.enabled = true
            }
        }
    }
}
