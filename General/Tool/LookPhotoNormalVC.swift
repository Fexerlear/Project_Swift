//
//  LookPhotoNormalVC.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/8/29.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LookPhotoNormalVC: BaseController, UIScrollViewDelegate {

    /// 标题
    var vctitle = "详情"
    /// 图片名称
    var imageName = ""
    /// 图片实际大小
    var imageSize = CGSize(width: 0, height: 0)
    
    
    private var scrollView:UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vctitle
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = self.view.bounds
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        
        // 适应屏幕宽度
        let screen_height = kScreenWidth / imageSize.width * imageSize.height
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight)
        scrollView.addSubview(imageView)
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NJLog(message: "x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
        
    }
    
    
}

