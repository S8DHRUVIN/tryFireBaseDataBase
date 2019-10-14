//
//  Items.swift
//  
//
//  Created by Dhruvin Shiyani on 24/09/19.
//

import Foundation
import FireBaseDataBase
import Firebase


class Item{
    
    var ref: DatabaseReference?
    var title: String?
    
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
        
    }
    
}

//
