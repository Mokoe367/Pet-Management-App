//
//  PetDataModel.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/15/23.
//

import Foundation
import SwiftUI

class Pet2: Identifiable, ObservableObject {
    var name: String = "Minty"
    var breed: String = "Maltese"
    var birthday: Date = Date()
    var tag: Int = 12345
    var note: String = "Rat rat rat rat rat"
}

class petList: ObservableObject {
    var pets: [Pet] = []
}

private struct petListKey: EnvironmentKey {
    static var defaultValue: petList = petList()
}

extension EnvironmentValues {
    var pets: petList {
        get { self[petListKey.self] }
        set { self[petListKey.self] = newValue }
    }
}

