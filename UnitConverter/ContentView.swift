//
//  ContentView.swift
//  UnitConverter
//
//  Created by Alex Po on 13.05.2022.
//

import SwiftUI

enum Measure: String, CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles
    //var id: String {self.rawValue}
}

struct ContentView: View {

    @State private var inputValue: Double = 1
    @State private var inputUnit = Measure.meters
    @State private var outputUnit =  Measure.yards
    
    private var outputValue: Double {
        convert(lengh: inputValue, from: inputUnit, to: outputUnit)
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 5
        return formatter
    }()
    
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("Enter original value and unit") {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Select: ", selection: $inputUnit) {
                        ForEach(Measure.allCases, id:\.self) {unit in
                            
                            Text(unit.rawValue)
                        }
                    
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                    Section {
                        Picker("Select: ", selection: $outputUnit) {
                            ForEach(Measure.allCases, id:\.self) {unit in
                                
                                Text(unit.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Text("\(NSNumber(value: outputValue), formatter: formatter)")
                    } header: {
                        Text("And choose unit to convert")
                    }
            }
            .navigationTitle("Lenght converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    func calculate(lenght baseValue: Double, in unit: Measure) -> Double {
        switch unit {
        case .meters:
            return baseValue
        case .kilometers:
            return baseValue / 1000
        case .feet:
            return baseValue * 3.28084
        case .yards:
            return baseValue * 1.09361
        case .miles:
            return baseValue / 1609.34
        }
    }
    
    func convert(lengh input: Double, from: Measure, to unit: Measure) -> Double {
        let baseValue: Double
        switch from {
        case .meters:
            baseValue = input
        case .kilometers:
            baseValue = input * 1000
        case .feet:
            baseValue = input / 3.28084
        case .yards:
            baseValue = input / 1.09361
        case .miles:
            baseValue = input * 1609.34
        }
        return calculate(lenght: baseValue, in: unit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
