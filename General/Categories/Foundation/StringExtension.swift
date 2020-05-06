//
//  StringExtension.swift
//  DaNeng
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation
import UIKit

/***
 方案一使用： 邮箱网址手机号码等正则判断
 
 Validate.email("Dousnail@@153.com").isRight //false
 
 Validate.URL("https://www.baidu.com").isRight //true
 
 Validate.IP("11.11.11.11").isRight //true
 */
enum Validate {
    case email(_: String)
    case phoneNum(_: String)
    case carNum(_: String)
    case username(_: String)
    case password(_: String)
    case nickname(_: String)
    
    case URL(_: String)
    case IP(_: String)
    
    
    var isRight: Bool {
        var predicateStr:String!
        var currObject:String!
        switch self {
        case let .email(str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
        case let .phoneNum(str):
            predicateStr = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
            currObject = str
        case let .carNum(str):
            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
            currObject = str
        case let .username(str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currObject = str
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
            currObject = str
        case let .nickname(str):
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
            currObject = str
        case let .URL(str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
        }
        
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
}

/***
 * 方案二使用： 手机号码正则判断
 */
internal extension String {
    /*
     * 验证手机号的格式。
     */
    
    static func isTelNumber(num: String) -> Bool {
        
        /**
         * 手机号码
         * 移动：134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188 198
         * 联通：130 131 132 145 155 156 166 171 175 176 185 186
         * 电信：133 149 153 173 177 180 181 189 199
         * 虚拟运营商: 170
         */
        
        // 2018-12-03 10:33:53 只限制是11位的1开头的号码
        let target = "^(0|86|17951)?(1[0-9])[0-9]{9}$"
        // let target = "^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]|17[01345678]|18[0-9]|14[579])[0-9]{8}$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,target)
        return predicate.evaluate(with: num)
        
    }
    
}

extension String {
    
   
    /**
     Get the height with font.
     
     - parameter font:       The font.
     - parameter fixedWidth: The fixed width.
     
     - returns: The height.
     */
    func heightWithFont(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        
        let size = CGSize(width:fixedWidth, height:CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        
        return rect.size.height
    }
    
   
}

extension String {
    /// 字符串的匹配范围  (推荐)
    ///
    /// - Parameters:
    ///     - matchStr: 要匹配的字符串
    /// - Returns: 返回所有字符串范围
    @discardableResult
    func hw_exMatchStrRange(_ matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") //辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }
}


// MARK: - Bridge
public extension String {
    
    /// 返回桥接版的 NSString
    var ns: NSString {
        return self as NSString
    }
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

// MARK: - Urils
public extension String {
    /// 给空值提供默认替换值, 如果 string 为空字符串，则使用指定的默认值替换
    ///
    /// - Parameter value: 指定用来替换的值
    func emptyDefault(_ value: String) -> String {
        return self.isEmpty ? value : self
    }
    
    /// 判断 String 是否不为空
    var notEmpty: Bool {
        return !isEmpty
    }
}

// MARK: - 拼音

public extension String {
    
    /// 拼音的类型
    enum PinyinType {
        case normal         // 默认类型，不带声调
        case withTone       // 带声调的拼音
        case firstLetter    // 拼音首字母
    }
    
    func pinyin(_ type: PinyinType = .normal) -> String {
        switch type {
        case .normal:
            return normalPinyin()
        case .withTone:
            return pinyinWithTone()
        case .firstLetter:
            return pinyinFirstLetter()
        }
    }
    
    private func pinyinWithTone() -> String {
        //转换为带声调的拼音
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        return nameRef! as String
    }
    
    private func normalPinyin() -> String {
        //去除声调
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(nameRef, nil, kCFStringTransformStripDiacritics, false)
        return nameRef! as String
    }
        
    private func pinyinFirstLetter() -> String {
        let pinyinString = pinyin() as NSString
        return pinyinString.substring(to: 1)
    }
}

// MARK: - Base64
public extension String {
    
    var base64Decode: String? {
        
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var base64Encode: String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
}

// MARK: - RegEx
public extension String {
    /// 常用正则表达式
    // 邮箱
    var regex_email: String {
        return "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
    }
    
    // 电话号码
    var regex_phone: String {
        return "^(([+])\\d{1,4})*(\\d{3,4})*\\d{7,8}(\\d{1,4})*$"
    }
    
    // 手机号码
    var regex_mobile: String {
        return "^(([+])\\d{1,4})*1[0-9][0-9]\\d{8}$"
    }

    /// 判断是否匹配正则表达式
    func match(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 判断字符串是否是邮箱
    var isEmail: Bool {
        return self.match(regex: regex_email)
    }
    
    /// 判断是否是电话号码
    var isPhone: Bool {
        return self.match(regex: regex_phone)
    }

    /// 判断是否是手机号码
    var isMobile: Bool {
        return self.match(regex: regex_mobile)
    }
    
    /// 同时验证电话和手机
    var isPhoneOrMobile: Bool {
        return isPhone || isMobile
    }
}

// MARK: - URL
public extension String {
    
    /// URL 编码
    var URLEncode: String? {
        let characterSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`")
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
    
    /// URL 解码
    var URLDecode: String? {
        return self.removingPercentEncoding
    }
    
    /// 转为URL
    ///
    /// - Returns: URL
    func k_toURL() -> URL? {
        return URL(string: self)
    }
}

// MARK: - Bounding Rect
public extension String {
    
    /**
     *  计算字符串的大小，根据限定的高或者宽度，计算另一项的值
     */
    func width(limitToHeight height: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return self.size(limitToSize: size, font: font).width
    }
    
    func height(limitToWidth width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.size(limitToSize: size, font: font).height
    }
    
    func size(limitToSize size: CGSize, font: UIFont) -> CGSize {
        let string = self as NSString
        let rect = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font:font], context: nil)
        return rect.size
    }
    
    /// 计算文字尺寸
    ///
    /// - Parameters:
    ///   - size: 包含一个最大的值 CGSize(width: max, height: 20.0)
    ///   - font: 字体大小
    /// - Returns: 尺寸
    func k_boundingSize(size: CGSize, font: UIFont) -> CGSize {
       return NSString(string: self).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
    
    /// 裁剪字符串
    ///
    /// - Parameters:
    ///   - from: 开始位置 从0开始
    ///   - to: 结束位置 包含这个位置
    ///   var str: String = "0123456789"
    ///   str = str[1, 9]
    ///   输出: str = "123456789"
    /// - Returns: 新字符串
    func k_subText(from: Int = 0, to: Int) -> String {
        if from > to { return self }
        
        let startIndex = self.startIndex
        let fromIndex = self.index(startIndex, offsetBy: max(min(from, self.count - 1), 0))
        let toIndex = self.index(startIndex, offsetBy: min(max(0, to), self.count - 1))
        
        return String(self[fromIndex ... toIndex])
    }
}

// MARK: -常规判断
public extension String {
    
    /// 是否包含Emoij
    ///
    /// - Returns: 是/否
    func k_containsEmoij() -> Bool {
        
        return self.k_isRegularCorrect("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]")
    }
    
    /// 移除字符串中的Emoij
    ///
    /// - Returns: 新字符串
    func k_deleteEmoij() -> String {
        
        return self.k_removeMatchRegular(expression: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", with: "")
    }
    
    /// 是否为空, 全空格/empty
    ///
    /// - Returns: 是否
    var k_isEmpty: Bool {
        if self.isEmpty {
            return true
        }
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    /// 是否是数字
    var k_isNumber: Bool {
        return self.k_isRegularCorrect("^[0-9]+$")
    }
    
    /// 是否是字母
    var k_isLetter: Bool {
        return self.k_isRegularCorrect("^[A-Za-z]+$")
    }
    
    /// 是否符合邮箱规则
    var k_isEmail: Bool {
        return self.k_isRegularCorrect("^([A-Za-z0-9_\\-\\.\\u4e00-\\u9fa5])+\\@([A-Za-z0-9_\\-\\.\\u4e00-\\u9fa5])+\\.([A-Za-z\\u4e00-\\u9fa5]+)$")
    }
    
    /// 是否包含汉字
    var k_isHasChinese: Bool {
        for chara in self {
            if chara >= "\u{4E00}" && chara <= "\u{9FA5}" {
                return true
            }
        }
        return false
    }
    
    /// 是否符合手机号码规则
    var k_isPhoneNum: Bool {
        
        // 全是数字, 不是空格
        return !self.k_isEmpty && self.trimmingCharacters(in: CharacterSet.decimalDigits).count == 0 && !self.k_isHasChinese
    }
    
    /// 密码是否符合规则 6-16位字母或数组
    var k_isPassword: Bool {
        return self.k_isRegularCorrect("^[^\\u4E00-\\u9FA5\\uF900-\\uFA2D\\u0020]{6,16}")
    }
    
    /// 是否符合身份证规则
    var k_isIdCard: Bool {
        
        return self.k_isRegularCorrect("^(\\d{14}|\\d{17})(\\d|[xX])$")
    }
    
    /// 正则是否匹配-谓词方式
    ///
    /// - Parameter str: str
    /// - Returns: 是否
    func k_isRegularCorrect(_ str: String) -> Bool {
        
        return NSPredicate(format: "SELF MATCHES %@", str).evaluate(with: self)
    }
}

// MARK: -正则表达式
public extension String {
    
    /// 是否符合正则表达式
    ///
    /// - Parameter expression: 正则表达式
    /// - Returns: 结果
    func k_isMatchRegular(expression: String) -> Bool {
        if let regularExpression = try? NSRegularExpression.init(pattern: expression, options: NSRegularExpression.Options.caseInsensitive) {
            return regularExpression.matches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.count)).count > 0
        }
        return false
    }
    
    /// 是否包含符合正则表达式的字符串
    ///
    /// - Parameter expression: 正则表达式
    /// - Returns: 结果
    func k_isContainRegular(expression: String) -> Bool {
        if let regularExpression = try? NSRegularExpression.init(pattern: expression, options: NSRegularExpression.Options.caseInsensitive) {
            return regularExpression.rangeOfFirstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: self.count)).location != NSNotFound
        }
        return false
    }
    
    /// 替换符合正则表达式的文字
    ///
    /// - Parameters:
    ///   - expression: 正则表达式
    ///   - newStr: 替换后的文字
    /// - Returns: 新字符串
    func k_removeMatchRegular(expression: String, with newStr: String) -> String {
        if let regularExpression = try? NSRegularExpression.init(pattern: expression, options: NSRegularExpression.Options.caseInsensitive) {
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: self.count), withTemplate: newStr)
        }
        return self
    }
    
    /// 获取所有符合正则表达式的文字位置
    ///
    /// - Parameter expression: 正则表达式 eg: "@[\\u4e00-\\u9fa5\\w\\-\\_]+ "="@ZCC "
    /// - Returns: [位置]?
    func k_matchRegularRange(expression: String) -> [NSRange]? {
        if let regularExpression = try? NSRegularExpression.init(pattern: expression, options: NSRegularExpression.Options.caseInsensitive) {
            return regularExpression.matches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.count)).map({ (result) -> NSRange in
                return result.range
            })
        }
        return nil
    }
}

// MARK: -文字转图片
public extension String {
    
    /// 文字转图片
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    /// - Returns: 图片
    func k_toTextImage(font: UIFont, textColor: UIColor) -> UIImage? {
        
        let imgHeight: CGFloat = 16.0
        let imgWidth = self.k_boundingSize(size: CGSize(width: UIScreen.main.bounds.width, height: imgHeight), font: font).width
        
        let attributeStr = NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: textColor])
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imgWidth, height: imgHeight), false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setCharacterSpacing(10.0)
        context?.setTextDrawingMode(CGTextDrawingMode.fill)
        context?.setFillColor(UIColor.white.cgColor)
        
        attributeStr.draw(in: CGRect(x: 0.0, y: 0.0, width: imgWidth, height: imgHeight))
        
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImg
    }
}

// MARK: -二维码相关
extension String {
    
    /// 生成二维码
    ///
    /// - Parameters:
    ///   - centerImg: 中间的小图
    ///   - block: 回调
    public func k_createQRCode(centerImg: UIImage? = nil) -> UIImage? {
        
        if self.k_isEmpty {
            return nil
        }
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(self.data(using: String.Encoding.utf8, allowLossyConversion: true), forKey: "inputMessage")
        if let image = filter?.outputImage {
            let size: CGFloat = 300.0
            
            let integral: CGRect = image.extent.integral
            let proportion: CGFloat = min(size/integral.width, size/integral.height)
            
            let width = integral.width * proportion
            let height = integral.height * proportion
            let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
            let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
            
            let context = CIContext(options: nil)
            if let bitmapImage: CGImage = context.createCGImage(image, from: integral) {
                bitmapRef.interpolationQuality = CGInterpolationQuality.none
                bitmapRef.scaleBy(x: proportion, y: proportion);
                bitmapRef.draw(bitmapImage, in: integral);
                if let image: CGImage = bitmapRef.makeImage() {
                    var qrCodeImage = UIImage(cgImage: image)
                    if let centerImg = centerImg {
                        // 图片拼接
                        UIGraphicsBeginImageContextWithOptions(qrCodeImage.size, false, UIScreen.main.scale)
                        qrCodeImage.draw(in: CGRect(x: 0.0, y: 0.0, width: qrCodeImage.size.width, height: qrCodeImage.size.height))
                        centerImg.draw(in: CGRect(x: (qrCodeImage.size.width - 35.0) / 2.0, y: (qrCodeImage.size.height - 35.0) / 2.0, width: 35.0, height: 35.0))
                        
                        qrCodeImage = UIGraphicsGetImageFromCurrentImageContext() ?? qrCodeImage
                        UIGraphicsEndImageContext()
                        return qrCodeImage
                    } else {
                        return qrCodeImage
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    //MARK: - 生成高清的UIImage
    func _setUpHighDefinitionImage(_ image: CIImage, size: CGFloat) -> UIImage? {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        if let image: CGImage = bitmapRef.makeImage() {
            return UIImage(cgImage: image)
        }
        return nil
    }
}

// MARK: - emoji
extension String {
    
    /// SwifterSwift: Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF, // Misc symbols
            0x2700...0x27BF, // Dingbats
            0xE0020...0xE007F, // Tags
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
