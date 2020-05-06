//
//  NormalWebVC.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/1/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import WebKit



class NormalWebVC: BaseController {
    
    var webURL = ""
    var vctitle = ""
    /// 是否可以通过点击返回按钮返回上一步，默认不可以
    var iscanGoback = false
    /// 是否加载自定义js，默认不加载
    var isloadJs = false

    /// title：标题 url：链接地址 iscanGoback：是否支持返回上一个页面 isloadJs：是否加载js注入
    convenience init(title: String, url: String, iscanGoback: Bool = false, isloadJs: Bool = false) {
        self.init()
        self.vctitle = title
        self.webURL = url
        self.iscanGoback = iscanGoback
        self.isloadJs = isloadJs
        
    }
    

    private lazy var closeItem: UIBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "popview_close_img"), style: .plain) { (str) in
        self.navigationController?.popViewController(animated: true)
    }
    
    private lazy var web: WKWebView = {
        var webView = WKWebView()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), configuration: WKWebViewConfiguration())
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var att = mobclick_attributes
        att["weburl"] = self.webURL
        MobClick.event("wyeth_webload", attributes: att as [AnyHashable : Any])
        
        self.title = vctitle
        
        // 是否加载js代码控制页面
        if isloadJs {
            //以下代码适配大小
            let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"
            let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            let wkUController = WKUserContentController()
            wkUController.addUserScript(wkUScript)
            let wkWebConfig = WKWebViewConfiguration()
            wkWebConfig.userContentController = wkUController
            web = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), configuration: wkWebConfig)
        }
        
        
        self.view.addSubview(web)
        web.k_progressColor = HexColor().Color_0E80FD

        self.request()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        web.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        
    }
    override func pop() {
        if iscanGoback {
            if self.web.canGoBack {
                self.web.goBack()
                self.navigationItem.leftBarButtonItems = [self.leftBarBtn, self.closeItem]

            } else {
                super.pop()
            }
            
        } else {
            super.pop()
            
        }
    }
    
    func request() {
        let url = URL(string: self.webURL)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        web.load(request)
    }
}



