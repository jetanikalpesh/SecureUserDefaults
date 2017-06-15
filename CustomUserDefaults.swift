//
//  SecureUserDefaults.swift
//  SecureUserDefaults
//
//  Created by Kalpesh Jetani on 15/06/17.
//  Copyright © 2017 Sigmacoder. All rights reserved.
//

import Foundation
final class CustomUserDefaults : NSObject {
    
    //Warning:-
    //You are responsible to remove file created on local path
    
    deinit {
        if self.objSecureData.dictionary.count > 0{
            self.synchronize()
        }
    }
    
    private let rootKey : String
    private let objSecureData : SecureDataClass
    private let location : String
    
    init(rootkey:String) {
        self.rootKey = rootkey
        location = CustomUserDefaults.path(keyString: rootkey)
        self.objSecureData = CustomUserDefaults.decodeDataObject(location: location)
        super.init()
    }
    
    func set(_ value: Any?, forKey key: String) {
        self.setValue(value, forKey: key)
    }
    func removeObject(forKey key: String) {
        self.objSecureData.dictionary.removeValue(forKey: key)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let value = value{
            self.objSecureData.dictionary[key] = value
        }else{
            self.objSecureData.dictionary.removeValue(forKey: key)
        }
    }
    override func value(forKey key: String) -> Any? {
        return self.objSecureData.dictionary[key]
    }
    
    func synchronize() {
        NSKeyedArchiver.archiveRootObject(self.objSecureData, toFile: location)
    }
    
    private class func decodeDataObject(location:String) -> SecureDataClass {
        if let objSecureDataClass = NSKeyedUnarchiver.unarchiveObject(withFile: location) as? SecureDataClass{
            return objSecureDataClass
        }
        return SecureDataClass()
    }
    
    func resetSecureUserDefaults() {
        
        let fileManager : FileManager = FileManager.default
        try? fileManager.removeItem(atPath: location)
        objSecureData.dictionary = [:]
    }
    
    class func path(keyString:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = (documentsPath)! + "/\(keyString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed))"
        return path
    }
}

fileprivate class SecureDataClass: NSObject, NSCoding {
    
    var dictionary : [String:Any] = [:]
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let dictionary = aDecoder.decodeObject(forKey: "SecureDataClass.dictionary") as? [String:Any]
            else {
                return nil
        }
        self.dictionary = dictionary
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dictionary, forKey: "SecureDataClass.dictionary")
    }
}
