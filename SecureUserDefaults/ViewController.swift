//
//  ViewController.swift
//  SecureUserDefaults
//
//  Created by Kalpesh on 15/06/17.
//  Copyright © 2017 Sigmacoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textField.text = SecureUserDefaults.standard.value(forKey: "Data") as? String

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK:- Actions
    @IBAction func buttonSavePressed(_ sender: Any) {
        
        SecureUserDefaults.standard.setValue(textField.text!, forKey: "Data")
        SecureUserDefaults.standard.syncronize()
        
    }
    
    @IBAction func buttonLoadPressed(_ sender: Any) {
        textField.text = SecureUserDefaults.standard.value(forKey: "Data") as? String

    }
    
    @IBAction func buttonResetPressed(_ sender: Any) {
        SecureUserDefaults.standard.resetAllDefaults()
    }


}

