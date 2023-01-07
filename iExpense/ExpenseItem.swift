//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ярослав Грогуль on 07.01.2023.
//

import Foundation


struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
