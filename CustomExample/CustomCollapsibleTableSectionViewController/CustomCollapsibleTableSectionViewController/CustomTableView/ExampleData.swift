//
//  ExampleData.swift
//
//  Created by Talha Qamar on 27/10/18.
//  Copyright © 2018 devtalha.com. All rights reserved.
//
import Foundation

public struct Item {
    var name: String
    var detail: String
    var id : String
    
    public init(name: String, detail: String, id: String) {
        self.name = name
        self.detail = detail
        self.id = id
    }
}

public struct Section {
    var name: String
    var count:String
    var items: [Item]
    var collapsed: Bool
    var status: Bool
    
    public init(name: String,count : String, items: [Item], collapsed: Bool,status : Bool) {
        self.name = name
        self.count = count
        self.items = items
        self.collapsed = collapsed
        self.status = status
    }
    
  }

public var sectionsData: [Section] = [
    Section(name: "Fruits",count: "asd", items: [
       
        Item(name: "Mango", detail: "asd", id: "")
        
        ], collapsed: true, status: true
    ),
    Section(name: "Vegetables",count: "asd", items: [
         Item(name: "Tomato", detail: "asdad", id: "")
        ], collapsed: true, status: true ),
    Section(name: "Groceries",count: "asd", items: [
        Item(name: "Shampoo", detail: "asdqwe", id: "")
        ], collapsed: true, status: true )

 ]
