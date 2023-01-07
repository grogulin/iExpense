//
//  Expense.swift
//  iExpense
//
//  Created by Ярослав Грогуль on 07.01.2023.
//

import Foundation

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]()
}
