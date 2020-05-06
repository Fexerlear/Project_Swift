//
//  CNSearchBar.swift
//  DaNeng
//
//  Created by Mac on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

class CNSearchBar: UISearchBar {
    
    typealias CNSearchBarSearchButtonClickedBlock = (String) -> Void
    typealias CNSearchBarShouldBeginEditingBlock = (String) -> Void
    // Properties
    var BlockSearchClick: CNSearchBarSearchButtonClickedBlock?
    var BlockShouldBeginEditing: CNSearchBarShouldBeginEditingBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.placeholder = "搜索"
        ////        searchbar.setImage(UIImage(named: "Search_VisitPlan"), for: UISearchBarIcon.search, state: .normal)
        self.searchBarStyle = .minimal
        self.sizeToFit()
        ////        let textFiled = searchbar.value(forKey: "searchField") as! UITextField
        ////        textFiled.backgroundColor = UIColor(hexString: "e3e3e3")
        //        //        textFiled.layer.borderWidth = 1
        //        //        textFiled.layer.borderColor = UIColor(hexString: "e3e3e3").cgColor
        //        //        textFiled.layer.cornerRadius = 6
        //        //        textFiled.layer.masksToBounds = true
        ////        textFiled.font = UIFont.systemFont(ofSize: 15)
        //        //        textFiled.placeholder = "搜索关键字"
        //        //        searchbar.tintColor = UIColor(hexString: "da271e")
        ////        textFiled.frame.size.height = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CNSearchBar: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        searchBar.showsCancelButton = true
        //        searchBar.showsScopeBar = true
        //        let btn = searchBar.value(forKey: "searchButton") as! UIButton
        //        btn.setTitle("搜索", for: UIControlState.normal)
        //        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        //        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.BlockShouldBeginEditing!(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        self.BlockSearchClick!(searchBar.text!)
        
    }
    
}
