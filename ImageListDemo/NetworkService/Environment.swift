//
//  Environment.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import Foundation

enum Environment {
    case test
}

extension Environment {
    var baseURL: String {
        switch self {
        case .test:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
}
