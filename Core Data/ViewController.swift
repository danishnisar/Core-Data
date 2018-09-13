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
    var numberselectedvc:Int16 = 0
    var convertINT = 0
    var arrayList = [Noted]()
    
    @IBOutlet weak var textholder: UITextView!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    @IBOutlet weak var saveTitle: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

       // print("setcountanother",datasharingVC)
        sharedme = PersistanceInstance.shared
        textholder.delegate = self
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        convertINT = Int(numberselectedvc)
        setData()
        
        print("Count",arrayList.count)
        print("number",numberselectedvc)
    }
    
    func setData(){
        
        let userFetch = sharedme!.retriveMessage(Noted.self)
        arrayList = userFetch
        saveTitle.title = "Cancel"
        if arrayList.count == 0 {
            textholder.text = "Enter Some record"
            
            //saveOutlet.isEnabled = false
            
            
        }else {
            if arrayList.count >= convertINT {
                textholder.text = arrayList[convertINT-1].message
            }else{
                textholder.text = "Enter Some record"
            }
            //saveOutlet.isEnabled = true
        }
        
    }
  
    @IBAction func save(_ sender: UIBarButtonItem) {
      
        if numberselectedvc == 1 {
            
            if textholder.text != "Enter Some record"{
                
                let saveData = Noted(context: sharedme!.context)
                saveData.id = numberselectedvc
                saveData.message = textholder.text
                sharedme!.save()
                
            }
            
        }else {
            if arrayList.count >= convertINT {
                
                if textholder.text != arrayList[convertINT-1].message {
                    arrayList[convertINT-1].message = textholder.text
                    sharedme!.save()
                    
                }
                
            }else{
                if textholder.text == "Enter Some record"{
                    saveTitle.title = "Cancel"
                    self.navigationController?.popToRootViewController(animated: true)
                    return
                }
                let saveData = Noted(context: sharedme!.context)
                saveData.id = numberselectedvc
                saveData.message = textholder.text
                sharedme!.save()
                
            }

        }
        
       
        
        self.navigationController?.popToRootViewController(animated: true)
        

    }
    

}

extension ViewController:UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        saveTitle.title = "Save"
        if textView.text == "Enter Some record" {
            textView.text = ""
        }

    }

    
    
}

