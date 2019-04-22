//
//  GistSerializable.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

class GistSerializable: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        
        //encode the owner
        aCoder.encode(owner, forKey: "owner")
        
        //encode the gistID
        aCoder.encode(id, forKey: "gistID")
        
        //check if name is empty then encode it
        if name.isNilOrEmpty() {
            aCoder.encode(nil, forKey: "name")
        } else {
            aCoder.encode(name, forKey: "name")
        }
        
        aCoder.encode(_storage, forKey: "storage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        owner = (aDecoder.decodeObject(forKey: "owner") as? String)!
        id = (aDecoder.decodeObject(forKey: "gistID") as? String)!
        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        print("Decoder ran")
        print(">>>owner:   \(owner)")
        print(">>>ID: \(id)")
        print(">>>Name:   \(name)")
        
        _storage = (aDecoder.decodeObject(forKey: "storage") as? [String: String])!
        print(">>>>>>Storage: ", _storage)
    }
    
    
    private var _storage = [String: String]()
    
    private static let OWNER_KEY = "owner"
    var owner: String {
        get {
            return self._storage[GistSerializable.OWNER_KEY]!
        }
        set {
            self._storage[GistSerializable.OWNER_KEY] = newValue
        }
    }
    
    private static let NAME_KEY = "name"
    var name: String {
        get {
            return self._storage[GistSerializable.NAME_KEY]!
        }
        set {
            self._storage[GistSerializable.NAME_KEY] = newValue
        }
    }
    
    private static let ID_KEY = "id"
    var id: String {
        get {
            return self._storage[GistSerializable.ID_KEY]!
        }
        set {
            self._storage[GistSerializable.ID_KEY] = newValue
        }
    }
    
    required init(owner: String, id: String, name: String) {
        _storage[GistSerializable.OWNER_KEY] = owner
        _storage[GistSerializable.ID_KEY] = id
        _storage[GistSerializable.NAME_KEY] = name
        
        print("Inside the req init of gistSerializable", self._storage)
    }
    
    convenience init(dict: [String: String]) {
        self.init(owner: dict[GistSerializable.OWNER_KEY]!,
                  id: dict[GistSerializable.ID_KEY]!,
                  name: dict[GistSerializable.NAME_KEY]!)
    }
    
    func serialize() -> [NSString: NSString] {
        return _storage as [NSString : NSString]
    }
}
