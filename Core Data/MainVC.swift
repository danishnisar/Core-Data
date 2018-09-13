//
//  MainVC.swift
//  Core Data
//
//  Created by MacBook Prp on 11/09/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    
    var sharedSingltonCoredata:PersistanceInstance?
    
    @IBOutlet weak var noteTable: UITableView!
    lazy var refreshme: UIRefreshControl = {
       let refreshing = UIRefreshControl()
        refreshing.attributedTitle = NSAttributedString(string: "Updating..")
        refreshing.addTarget(self, action: #selector(refrehsme(_:)), for: .valueChanged)
        return refreshing
    }()
    
    var listArray = [Noted]()
    var numberSelect:Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedSingltonCoredata = PersistanceInstance.shared
        registercellandtable()

    }
   
    
    private func registercellandtable(){
    
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        noteTable.delegate = self
        noteTable.dataSource = self
        noteTable.register(UINib(nibName: "CellVC", bundle: nil), forCellReuseIdentifier: "notecell")
        
        if #available(iOS 10.0, *) {
            noteTable.refreshControl = refreshme
        } else {
            // Fallback on earlier versions
            
        }
   
        
        
        
        retriveData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retriveData()
    }
    
    @objc func refrehsme(_ sender: Any){
        refreshme.beginRefreshing()
        retriveData()
    }
    
    func retriveData(){
       print("data again start")
       let data =  sharedSingltonCoredata!.retriveMessage(Noted.self)
        listArray = data
        //print("Data",data)
        
        DispatchQueue.main.async {
                self.noteTable.reloadData()
                self.refreshme.endRefreshing()
            print("data again End")
        }
        
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
        let vc = segue.destination as! ViewController
            vc.numberselectedvc = numberSelect
        }
    }
    
    @IBAction func Compose(_ sender: UIBarButtonItem) {
    
        let setcount = (listArray.count == 0) ? 1 : listArray.last!.id + 1
        print("setcount",setcount)
        print("listArray.count",listArray.count)
        numberSelect = Int16(setcount)
        
        performSegue(withIdentifier: "detail", sender: self)
    }
    

}

extension MainVC:UITableViewDelegate,UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! CellVC
        cell.title.text = listArray[indexPath.row].message;
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        numberSelect = Int16(indexPath.row)+1
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "X") { (action, indexPath) in
            print("perform Delete on",indexPath.row)
          
            //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.sharedSingltonCoredata!.deleteObj(object:self.listArray[indexPath.row])
           
                self.noteTable.reloadData()
           
        }
        

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.0
    }
    
    
    
    
    
    
}
