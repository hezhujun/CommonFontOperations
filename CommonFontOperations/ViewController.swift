//
//  ViewController.swift
//  CommonFontOperations
//
//  Created by 何柱君 on 2022/5/1.
//

import UIKit
import SnapKit
import CoreText
import UniformTypeIdentifiers

class ViewController: UIViewController {
    
    let textView = UITextView()
    
    let registerButton = UIButton()
    let resignButton = UIButton()
    let importButton = UIButton()
    
    var registedUrl: URL?
    var fontFileUrlHandler: ((URL)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        print(UIFont.familyNames)
        
        let defaultAttributedString = NSAttributedString(string: "system default font\n", attributes: nil)
        
        // use 3-1
        let fontDescriptor31 = createFontDescriptor(fromName: "Times New Roman", size: 12)
        let font31 = CTFontCreateWithFontDescriptor(fontDescriptor31, 0, nil)
        let attributedString31 = NSAttributedString(string: "Listing 3-1 Times New Roman\n", attributes: [.font: font31])
        
        // use 3-2
        let fontDescriptor32 = listing32()
        let font32 = CTFontCreateWithFontDescriptor(fontDescriptor32, 0, nil)
        let attributedString32 = NSAttributedString(string: "Listing 3-2 Papyrus\n", attributes: [.font: font32])
        
        // use 3-3
        let font33 = listing33()
        let attributedString33 = NSAttributedString(string: "Listing 3-3 Courier\n", attributes: [.font: font33])
        
        // use 3-4
        let font34Normal = UIFont.systemFont(ofSize: 12)
        let font34Bold = createBoldFont(font: font34Normal, makeBold: true)
        var attributedString34: NSAttributedString?
        if font34Bold != nil {
            let part1 = NSAttributedString(string: "Listing 3-4 normal ", attributes: [.font: font34Normal])
            let part2 = NSAttributedString(string: "Bold\n", attributes: [.font: font34Bold!])
            let compose = NSMutableAttributedString()
            compose.append(part1)
            compose.append(part2)
            attributedString34 = NSAttributedString(attributedString: compose)
        }
        
        // use 3-5
        let font35before = UIFont.init(name: "System Font", size: 15)!
        let font35after = createFontConvertedToFamily(font: font35before, family: "Times New Roman")
        var attributedString35: NSAttributedString?
        if font35after != nil {
            let part1 = NSAttributedString(string: "Listing 3-5 ", attributes: [.font: font35before])
            let part2 = NSAttributedString(string: "Listing 3-5\n", attributes: [.font: font35after!])
            let compose = NSMutableAttributedString()
            compose.append(part1)
            compose.append(part2)
            attributedString35 = NSAttributedString(attributedString: compose)
        }
        
        // use 3-8
        let attributedString38 = NSMutableAttributedString(string: "1234567890")
        listing38(attrString: attributedString38, range: CFRange(location: 0, length: 5))
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(defaultAttributedString)
        attributedString.append(attributedString31)
        attributedString.append(attributedString32)
        attributedString.append(attributedString33)
        if attributedString34 != nil {
            attributedString.append(attributedString34!)
        }
        if attributedString35 != nil {
            attributedString.append(attributedString35!)
        }
        attributedString.append(attributedString38)
        textView.attributedText = attributedString
    }


}

// 实例代码
extension ViewController {
    // MARK: Listing 3 - 1
    func createFontDescriptor(fromName name: String, size: CGFloat) -> CTFontDescriptor {
        return CTFontDescriptorCreateWithNameAndSize(name as CFString, size)
    }
    
    // MARK: Listing 3 - 2
    func listing32() -> CTFontDescriptor {
        let familyName = "Papyrus"
        let symbolicTraits = CTFontSymbolicTraits.traitCondensed
        let size: CGFloat = 24.0
        
        let traits: [NSString: Any] = [
            kCTFontSymbolicTrait: symbolicTraits
        ]
        
        let attributes: [NSString: Any] = [
            kCTFontFamilyNameAttribute: familyName,
            kCTFontSymbolicTrait: traits,
            kCTFontSizeAttribute: size
        ]
        
        let descriptor = CTFontDescriptorCreateWithAttributes(attributes as CFDictionary)
        return descriptor
    }
    
    // MARK: Listing 3 - 3
    func listing33() -> CTFont {
        let fontAttributes: [NSString: Any] = [
            kCTFontFamilyNameAttribute: "Courier",
            kCTFontStyleNameAttribute: "Bold",
            kCTFontSizeAttribute: 16,
        ]
        let descriptor = CTFontDescriptorCreateWithAttributes(fontAttributes as CFDictionary)
        let font = CTFontCreateWithFontDescriptor(descriptor, 0, nil)
        return font
    }
    
    // MARK: Listing 3 - 4
    func createBoldFont(font: CTFont, makeBold: Bool) -> CTFont? {
        var desiredTrait: CTFontSymbolicTraits = .init(rawValue: 0)
        let traitMask: CTFontSymbolicTraits = .traitBold
        
        if makeBold {
            desiredTrait = CTFontSymbolicTraits.traitBold
        }
        
        return CTFontCreateCopyWithSymbolicTraits(font, 0.0, nil, desiredTrait, traitMask)
    }
    
    // MARK: Listing 3 - 5
    func createFontConvertedToFamily(font: CTFont, family: String) -> CTFont? {
        return CTFontCreateCopyWithFamily(font, 0.0, nil, family as CFString)
    }
    
    // MARK: Listing 3 - 6
//    func createFlattenedFontData(font: CTFont) -> Data? {
//        var error =
//        let descriptor = CTFontCopyFontDescriptor(font)
//        let attributes = CTFontDescriptorCopyAttributes(descriptor)
//        if CFPropertyListIsValid(attributes, .xmlFormat_v1_0) {
//            CFPropertyListCreateData(kCFAllocatorDefault, attributes, .xmlFormat_v1_0, .zero, <#T##error: UnsafeMutablePointer<Unmanaged<CFError>?>!##UnsafeMutablePointer<Unmanaged<CFError>?>!#>)
//            CFPropertyListCreateXMLData(nil, attributes)
//        }
//
//    }
    
    // MARK: Listing 3 - 7
//    func createFontFromFlattenedFontData(data: CFData) -> CTFont {
//
//    }
    
    // MARK: Listing 3 - 8
    func listing38(attrString: NSMutableAttributedString, range: CFRange) {
//        CFAttributedStringSetAttribute(attrString, range, kCTForegroundColorAttributeName, UIColor.red.cgColor)
        CFAttributedStringSetAttribute(attrString, range, kCTKernAttributeName, NSNumber(value: 20))
    }
    
    // MARK: Listing 3 - 9
//    func getGlyphsForCharacters(font: CTFont, string: String) {
//        let count = CFStringGetLength(string as CFString)
//        var characters = UniChar(0)
//        var glyhps = CGGlyph(0)
//        
//        CFStringGetCharacters(string, CFRangeMake(0, count), <#T##buffer: UnsafeMutablePointer<UniChar>!##UnsafeMutablePointer<UniChar>!#>)
//        CTFontGetGlyphsForCharacters(font, <#T##characters: UnsafePointer<UniChar>##UnsafePointer<UniChar>#>, <#T##glyphs: UnsafeMutablePointer<CGGlyph>##UnsafeMutablePointer<CGGlyph>#>, count)
//        
//    }
}

private extension ViewController {
    @objc func onButtonClick(_ sender: UIButton) {
        if sender === registerButton {
            registerFont()
        } else if sender === resignButton {
            resignFont()
        } else if sender === importButton {
            importFont()
        }
    }
    
    func registerFont() {
        fontFileUrlHandler = { [weak self] url in
            print(url)
            // MARK: - Listing 3 - 10
            // scope
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            
            self?.registedUrl = url
            
            guard let fontDescriptors = CTFontManagerCreateFontDescriptorsFromURL(url as CFURL) as? [CTFontDescriptor] else {
                return
            }
            guard let descriptor = fontDescriptors.first else { return }
            guard let attributes = CTFontDescriptorCopyAttributes(descriptor) as? [NSString: Any],
                    let name = attributes[kCTFontNameAttribute] as? NSString else {
                return
            }
            self?.registerButton.setTitle("注册字体[\(name)]", for: .normal)
            self?.registerButton.titleLabel?.font = UIFont(name: name as String, size: 15)
            self?.resignButton.setTitle("注销字体[\(name)]", for: .normal)
            self?.resignButton.titleLabel?.font = UIFont(name: name as String, size: 15)
        }
        
        importFontFile()
    }
    
    func resignFont() {
        if let url = registedUrl {
            // MARK: - Listing 3 - 10
            CTFontManagerUnregisterFontsForURL(url as CFURL, .process, nil)
        }
        
        registerButton.setTitle("注册字体", for: .normal)
        registerButton.titleLabel?.font = nil
        resignButton.setTitle("注销字体", for: .normal)
        resignButton.titleLabel?.font = nil
    }
    
    func importFont() {
        fontFileUrlHandler = { [weak self] url in
            print(url)
            // MARK: - Listing 3 - 11
            // 通过字体文件 url 创建 CTFontDescriptor
            guard let fontDescriptors = CTFontManagerCreateFontDescriptorsFromURL(url as CFURL) as? [CTFontDescriptor] else {
                return
            }
            // 打印字体信息
            fontDescriptors.forEach { descriptor in
                guard let attributes = CTFontDescriptorCopyAttributes(descriptor) as? [NSString: Any] else {
                    return
                }
                for (key, value) in attributes {
                    print("\(key): \(value)")
                }
            }
            
            guard let descriptor = fontDescriptors.first else { return }
            guard let attributes = CTFontDescriptorCopyAttributes(descriptor) as? [NSString: Any],
                    let name = attributes[kCTFontNameAttribute] as? NSString else {
                return
            }
            // 通过 fontDescriptor 创建 CTFont
            let font = CTFontCreateWithFontDescriptor(descriptor, 15, nil)
            self?.importButton.setTitle("直接使用字体[\(name)]", for: .normal)
            self?.importButton.titleLabel?.font = font
        }
        
        importFontFile()
    }
    
    
}

private extension ViewController {
    func importFontFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.font])
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        guard url.startAccessingSecurityScopedResource() else { return }
        defer { url.stopAccessingSecurityScopedResource() }
        
        var error: NSError? = nil
        NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { [weak self] url in
            self?.fontFileUrlHandler?(url)
        }
    }
}

private extension ViewController {
    func setupUI() {
        view.addSubview(textView)
        textView.isEditable = false
        textView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(registerButton)
        stackView.addArrangedSubview(resignButton)
        stackView.addArrangedSubview(importButton)
        
        registerButton.setTitle("注册字体", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.addTarget(self, action: #selector(onButtonClick(_:)), for: .touchUpInside)
        resignButton.setTitle("注销字体", for: .normal)
        resignButton.setTitleColor(.black, for: .normal)
        resignButton.addTarget(self, action: #selector(onButtonClick(_:)), for: .touchUpInside)
        importButton.setTitle("直接使用字体", for: .normal)
        importButton.setTitleColor(.black, for: .normal)
        importButton.addTarget(self, action: #selector(onButtonClick(_:)), for: .touchUpInside)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(textView.snp.bottom)
            make.height.equalTo(150)
        }
    }
}
