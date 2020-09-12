//
//  TextDataModel.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation

enum Results<T> {
    case success(T)
    case failure(errorStr: String)
}


class ModelResponse: NSObject, Decodable {
    
    var textDataModel: [String]?
    
    init(data: Data) throws {
        super.init()
        textDataModel = try? JSONDecoder().decode([String].self, from: data)
    }
}

