//
//  AddView.swift
//  iExpense
//
//  Created by Ярослав Грогуль on 07.01.2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency!.identifier))
                    .keyboardType(.decimalPad)
                
                Button("Test") {
                    let currency = ""
                    print(currency)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button {
                    if name.count > 0 {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                    }
                    dismiss()
                } label: {
                    if name.count > 0 {
                        Image(systemName: "square.and.arrow.down.on.square")
                    } else {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
