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
    let refresh:UIRefreshControl = {
       let refreshing = UIRefreshControl()
        refreshing.attributedTitle = NSAttributedString(string: "Updating..")
        refreshing.addTarget(self, action: #selector(refrehsme), for: .valueChanged)
        return refreshing
    }()
    
    var listArray = [Employ]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedSingltonCoredata = PersistanceInstance.shared
        registercellandtable()

    }

    private func registercellandtable(){
        
        noteTable.register(UINib(nibName: "CellVC", bundle: nil), forCellReuseIdentifier: "notecell")
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        noteTable.delegate = self
        noteTable.dataSource = self
        
        noteTable.refreshControl = refresh
     
    }
    @objc func refrehsme(){
        refresh.beginRefreshing()
    }
    
    func retriveData(){
       let data =  sharedSingltonCoredata!.retriveMessage(Employ.self)
        listArray = data
        print("Data",data)
    }
    

}

extension MainVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! CellVC
        cell.title.text = listArray[indexPath.row].message;
        return cell
    }
    
    
    
    
    
}
