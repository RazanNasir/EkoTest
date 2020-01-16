//
//  ViewController.swift
//  Github Users
//
//  Created by Razan Nasir on 15/01/20.
//  Copyright © 2020 Razan Nasir. All rights reserved.
//

import UIKit

class UserListVC: UIViewController {

    var valuesData = [UserListlModel]()
    var pageNumber = 0
    @IBOutlet var tableView : UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.valuesData.removeAll()
        GetUserList(pageNumber: pageNumber)
        registeredCells()
    }
     func registeredCells(){
        tableView.register(UINib(nibName: "userCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    func GetUserList(pageNumber : Int){
        let urlString = "APIServices".getUsersAPI+"?since=\(pageNumber)"
        AlamofireRequest.shared.getBodyFrom(urlString:urlString, isLoader: true, param: nil, loaderMessage: "Getting Info" , auth: nil) { (data, error) in
            if error == nil{
                if let dataTemp = data as? [[String:Any]]
                {
                           for dic in dataTemp{
                            let value = UserListlModel(fromDictionary: dic)
                            self.valuesData.append(value)
                            }
                            self.tableView.reloadData()
                            }
            }else{
                self.show(message: "\(String(describing: error))")
            }
    }

}
    func show(message :String){
        TinyToast.shared.dismissAll()
        TinyToast.shared.show(message: message, valign: .bottom, duration: .short)
    }
}
extension UserListVC : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return valuesData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let JsonValues = self.valuesData[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
        detailViewController.webUrl = JsonValues.html_url
        self.navigationController?.pushViewController(detailViewController, animated: true)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let JsonValues = self.valuesData[indexPath.row]
            let cell =  tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! userCell
            cell.favBtn.addTarget(self, action: #selector(favBtnAction(_ :)), for: .touchUpInside)
            cell.favBtn.tag = indexPath.row
            cell.fillData(jsonData: JsonValues)
        if  indexPath.row == valuesData.count - 1 {
            pageNumber = pageNumber + 1
            GetUserList(pageNumber: pageNumber)
        }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    @objc fileprivate func favBtnAction(_ sender : UIButton){
        let JsonValues = self.valuesData[sender.tag]
        if  JsonValues.isFav ?? false {
            JsonValues.isFav = false
        }else{
            JsonValues.isFav = true
        }
        self.tableView.reloadData()
    }
}
class alert {
    func msg(message: String, title: String = "")
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}
