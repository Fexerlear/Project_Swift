//
//  YLShowImageVC.swift
//  DaNeng
//
//  Created by Fexerlear on 2018/11/12.
//  Copyright © 2018年 Mac. All rights reserved.
//
// 本类只是作为展示单张图片使用
import UIKit

class YLShowImageVC: BaseController {

    // MARK: -  基础属性
    var vctitle = ""
    var imageName = ""
    var image = UIImage()
    private lazy var imageView: UIImageView = UIImageView.init()
    
    // MARK: -  视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vctitle
        self.view.backgroundColor = UIColor.black
        
        imageView.contentMode = .scaleAspectFit
        if imageName != "" {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: self.imageName), options: [.transition(.fade(0.0)), .cacheMemoryOnly])
        } else {
            imageView.image = self.image
        }
        imageView.setTapGestureForUIImageView_CN(target: self, action: #selector(self.dismissView))

        self.view.addSubview(imageView)
        
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
        
    }
    

}



// MARK: - 选择年份，最多10年，过了就再加
class YearPickerViewController: BaseController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    typealias YearPickerViewBlock = (Int) -> Void
    /// 获得回传数据，返回选中了哪行
    var pickBlock: YearPickerViewBlock?
    
    /// 数据源
    var dataList  = [String]()
    /// 选中了哪行
    private var selectRow: Int = 0
    
    // MARK: - Properties
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: kScreenHeight-(kScreenWidth/5*3), width: kScreenWidth, height: kScreenWidth/5*3))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.toolbarPlaceholder = "完成"
        return picker
    }()
    //
    private let done: UILabel = {
        let nextLogin = UILabel()
        nextLogin.text = "完成"
        nextLogin.textColor = HexColor().Color_0E80FD
        nextLogin.font = UIFont.adjustSystemFont(ofSize: 16)
        return nextLogin
    }()
    private let cancel: UILabel = {
        let nextLogin = UILabel()
        nextLogin.text = "取消"
        nextLogin.textColor = UIColor(hexString: "#666666")
        nextLogin.font = UIFont.adjustSystemFont(ofSize: 16)
        return nextLogin
    }()
    //
    private let topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor(hexString: "eeeeee")
        return topView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.view.addSubview(picker)
        self.view.addSubview(topView)
        self.view.addSubview(cancel)
        self.view.addSubview(done)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(picker)
            make.height.equalTo(40)
        }
        done.snp.makeConstraints { (make) in
            make.top.height.equalTo(topView)
            make.right.equalTo(topView).inset(10)
        }
        cancel.snp.makeConstraints { (make) in
            make.top.height.equalTo(topView)
            make.left.equalTo(topView).offset(10)
        }
        
        
        /// Add Events
        done.setTapGesture_CN(target: self, action: #selector(self.dismissVC))
        cancel.setTapGesture_CN(target: self, action: #selector(self.canceldismissVC))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Events
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
        self.pickBlock!(selectRow)
        
    }
    
    
    @objc func canceldismissVC() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.adjustBoldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        
        return label
    }
    
}
