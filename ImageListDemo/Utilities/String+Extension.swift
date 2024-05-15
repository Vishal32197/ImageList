//
//  String+Extension.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import Foundation

extension String {
    func asURL() -> URL? {
        return URL(string: self)
    }
}
