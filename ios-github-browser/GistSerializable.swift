//
//  GistSerializable.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

class GistSerializable {
    
    private var _storage = [String: String]()
    
    private static let OWNER_KEY = "owner"
    var owner: String {
        get {
            return self._storage[GistSerializable.OWNER_KEY]!
        }
    }
    
    private static let NAME_KEY = "name"
    var name: String {
        get {
            return self._storage[GistSerializable.NAME_KEY]!
        }
    }
    
    private static let ID_KEY = "id"
    var id: String {
        get {
            return self._storage[GistSerializable.ID_KEY]!
        }
    }
    
    required init(owner: String, id: String, name: String) {
        _storage[GistSerializable.OWNER_KEY] = owner
        _storage[GistSerializable.ID_KEY] = id
        _storage[GistSerializable.NAME_KEY] = name
    }
    
    convenience init(dict: [String: String]) {
        self.init(owner: dict[GistSerializable.OWNER_KEY]!,
                  id: dict[GistSerializable.ID_KEY]!,
                  name: dict[GistSerializable.NAME_KEY]!)
    }
    
    func serialize() -> [String: String] {
        return _storage
    }
}
