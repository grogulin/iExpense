//
//  Expense.swift
//  iExpense
//
//  Created by Ярослав Грогуль on 07.01.2023.
//

import Foundation

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var itemTypes: [String] {
        var types = [String]()
        
        for item in items {
            if types.firstIndex(of: item.type) == nil {
                types.append(item.type)
            }
        }
        return types
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
