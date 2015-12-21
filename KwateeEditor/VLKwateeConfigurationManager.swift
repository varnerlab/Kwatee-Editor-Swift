//
//  VLKwateeConfigurationManager.swift
//  KwateeEditor
//
//  Created by Jeffrey Varner on 12/21/15.
//  Copyright © 2015 Varnerlab. All rights reserved.
//

import Foundation

struct ModelType {
    
    var display_text:String?
    var input_handler_class:String?
    var output_handler_class:String?
}

class VLKwateeConfigurationManager {
    
    // static accesor -
    static let sharedInstance = VLKwateeConfigurationManager()
    
    // private instance variable -
    private var myConfigurationTree:NSXMLDocument?
    
    // private constructor
    private init() {
    
        // Load the Configuration.xml file -
        let path_to_configuration_tree = NSBundle.mainBundle().pathForResource("Configuration", ofType: "xml")
        let path_url = NSURL(fileURLWithPath:path_to_configuration_tree!)
        
        // Load the tree -
        do {
            
            // Build the configuration tree -
            self.myConfigurationTree = try NSXMLDocument(contentsOfURL: path_url, options: NSXMLDocumentTidyXML)
            
            // post to user -
            print("Loaded the configuration file at \(path_to_configuration_tree!)")
        }
        catch {
            
            // print error -
            print("ERROR: Unable to load the Configuration.xml file from the bundle at \(path_to_configuration_tree)")
        }
    }
    
    
    // MARK:- Lookup methods for configuration tree -
    
    // ------------------------------------------------------------------------------------------------------- //
    // lookupMyModelTypesFromConfigurationTree: use xpath to lookup model types from the configuration tree
    //
    // Returns:
    // Array for ModelType struct
    // ------------------------------------------------------------------------------------------------------- //
    func lookupMyModelTypesFromConfigurationTree() -> [ModelType]? {
        
        // method varaibles -
        var modelTypeArray:[ModelType] = Array<ModelType>()
        
        // Build xpath string -
        if let configuration_tree = self.myConfigurationTree {
            
            do {
                
                if let xml_node_array:[NSXMLElement] = try configuration_tree.nodesForXPath(".//listOfModelTypes/model_type") as? [NSXMLElement] {
                
                    // get the data from the node array -
                    for xml_element:NSXMLElement in xml_node_array {
                     
                        // get the data from the attributes -
                        let display_text = xml_element.attributeForName("display_text")?.stringValue
                        let input_handler_class = xml_element.attributeForName("input_handler_class")?.stringValue
                        let output_handler_class = xml_element.attributeForName("output_handler_class")?.stringValue
                        
                        // build the struct -
                        var model_type_struct:ModelType = ModelType()
                        model_type_struct.display_text = display_text!
                        model_type_struct.input_handler_class = input_handler_class!
                        model_type_struct.output_handler_class = output_handler_class!
                        
                        // cache -
                        modelTypeArray.append(model_type_struct)
                    }
                    
                    return modelTypeArray
                }
            }
            catch {
                
                // post message -
                print("ERROR: Failure to build array of model types")
            }
        }
        
        // return -
        return modelTypeArray
    }
}