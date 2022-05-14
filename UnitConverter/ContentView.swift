//
//  ContentView.swift
//  UnitConverter
//
//  Created by Alex Po on 13.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    @State private var selectedUnits = 0

    @State private var inputValue: Double = 1
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension =  UnitLength.yards
    
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
                Section("Conversion") {
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count, id: \.self) {
                            Text(conversions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section("Enter original value and unit") {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Select: ", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnits], id:\.self) {
                            Text(measurmentFormatter.string(from: $0))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                    Section {
                        Picker("Select: ", selection: $outputUnit) {
                            ForEach(unitTypes[selectedUnits], id:\.self) {
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
            .onChange(of: selectedUnits) { newSelection in
                let  units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[2]
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
