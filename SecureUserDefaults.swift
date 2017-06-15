//
//  SecureUserDefaults.swift
//  SecureUserDefaults
//
//  Created by Kalpesh on 15/06/17.
//  Copyright © 2017 Sigmacoder. All rights reserved.
//

import Foundation

open class SecureUserDefaults : NSObject {
    
    deinit {
        self.syncronize()
    }
    
    static var standard : SecureUserDefaults = SecureUserDefaults()
    private var objSecureData : SecureDataClass
    
    override init() {
        self.objSecureData = SecureUserDefaults.decodeDataObject()
        super.init()
    }
    
    open override func setValue(_ value: Any?, forKey key: String) {
        if let value = value{
            SecureUserDefaults.standard.objSecureData.dictionary[key] = value
        }else{
            SecureUserDefaults.standard.objSecureData.dictionary.removeValue(forKey: key)
        }
    }
    open override func value(forKey key: String) -> Any? {
        return SecureUserDefaults.standard.objSecureData.dictionary[key]
    }

    func syncronize() {
        NSKeyedArchiver.archiveRootObject(self.objSecureData, toFile: SecureUserDefaults.path)
    }
    
    private static func decodeDataObject() -> SecureDataClass {
        if let objSecureDataClass = NSKeyedUnarchiver.unarchiveObject(withFile: SecureUserDefaults.path) as? SecureDataClass{
            return objSecureDataClass
        }
        return SecureDataClass()
    }
    
    class var path : String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = (documentsPath)! + "/Configuration"
        return path
    }
    
    func resetSecureUserDefaults() {
        
        let fileManager : FileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: SecureUserDefaults.path)
            objSecureData.dictionary = [:]
        }
        catch
        {
            print("Error Removing User Details")
        }
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


