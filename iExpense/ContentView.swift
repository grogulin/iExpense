//
//  ContentView.swift
//  iExpense
//
//  Created by Ярослав Грогуль on 05.01.2023.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    @State private var types: [String] = ["Personal", "Business"]
    
    func amountSymbols(amount: Double) -> some View {
        var count = 0
        
        switch amount {
        case 0..<10: count = 1
        case 10..<100: count = 2
        case 100..<1000: count = 3
        default: count = 4
        }
        
        return HStack(spacing: 0) {
            ForEach(0..<count, id: \.self) {_ in
                Image(systemName: "dollarsign")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
            }
        }
    }
    
    func getTypes() {
        var typesLocal = Set<String>()
        for item in expenses.items {
            typesLocal.insert(item.type)
        }
        
        types = typesLocal.sorted()
    }
    
    func countItems(of type: String) -> Int {
        var cnt = 0
        for item in expenses.items {
            if item.type == type { cnt += 1 }
        }
        return cnt
    }
    
    func expenseRows(expenses: Expenses, type: String) -> some View {
//        return Text("Hello")
        
        return ForEach(expenses.items) {item in
            if item.type == type {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        HStack {
                            Text(item.type)
                            amountSymbols(amount: item.amount)
                        }
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency!.identifier))
                }
            }
        }
        .onDelete(perform: removeItems)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(types, id: \.self) {type in
                    if countItems(of: type) > 0 {
                        Section {
                            expenseRows(expenses: expenses, type: type)
                        } header: {
                            Text(type)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
        .onAppear {
            getTypes()
            print(types)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        getTypes()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
