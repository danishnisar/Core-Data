//
//  ViewController.swift
//  Core Data
//
//  Created by MacBook Prp on 10/09/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sharedme:PersistanceInstance?
    @IBOutlet weak var textholder: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        sharedme = PersistanceInstance.shared
    }

  
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let saveNotes = Employ(context: sharedme!.context)
        saveNotes.message = textholder.text
        sharedme!.save()
    }
    

}

