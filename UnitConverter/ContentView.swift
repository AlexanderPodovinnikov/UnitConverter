//
//  ContentView.swift
//  UnitConverter
//
//  Created by Alex Po on 13.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    let units: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]

    @State private var inputValue: Double = 1
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit =  UnitLength.yards
    
    var outputString: String {
        let inputMeasurment = Measurement(value: inputValue, unit: inputUnit)
        let outputMeasurment = inputMeasurment.converted(to: outputUnit)
        return measurmentFormatter.string(from: outputMeasurment)
    }
 
    let measurmentFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
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
                        ForEach(units, id:\.self) {
                            Text(measurmentFormatter.string(from: $0))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                    Section {
                        Picker("Select: ", selection: $outputUnit) {
                            ForEach(units, id:\.self) {
                                Text(measurmentFormatter.string(from: $0))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Text(outputString)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
