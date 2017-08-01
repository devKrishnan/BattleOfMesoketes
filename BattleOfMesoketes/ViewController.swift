//
//  ViewController.swift
//  BattleOfMesoketes
//
//  Created by radhakrishnan S on 27/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try  attackMaygans()

        } catch DataError.invalidDirection {
            print("Direction provided is invalid")
        }
        catch DataError.invalidStrength {
            print("Strength provided is invalid")
        }
        catch DataError.invalidAttackCount {
            print("Attack count  provided is invalid")
        }
        catch {
            print("Inpuut is invalid")
        }
                // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func attackMaygans() throws {
        parseData {  (warData: [String : Any])  in
            if let listOfWars = warData[Constants.warsKey] as? [[String:Any]] {
                for warDict in listOfWars {
                    if let war = War(warJSON: warDict){
                        let successCount =  war.initiateAttack()
                        print("No of successfull attacks in War with ID \(String(describing: war.warID)) is \(successCount )")
                    }else{
                        print("Invalid war object in JSON")
                    }
                   
                }
            }
            else {
                throw DataError.invalidWarData
            }
        }
        
    }
    func parseData(processedWardData: ([String : Any]) throws -> Void) {
        do {
            let bundle: Bundle = Bundle.main
            
            guard let jsonFileURL = bundle.url(forResource: "war", withExtension: "json") else {
                throw DataError.invalidFile
            }
            let contents = try Data(contentsOf: jsonFileURL)
            let jsonData = try JSONSerialization.jsonObject(with: contents, options: .allowFragments)
            guard let warData = jsonData as? [String : Any] else {
                throw DataError.invalidFileData
            }
            try processedWardData(warData)
            print(contents)
        }
        catch DataError.invalidFile {
            print("War data JSON file is invalid")
        }
        catch {
            print("Unknown error")
        }
    }

}
