//
//  Data+Extensions.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit

extension Data {
    /// It's used to convert JSON response of error to error model.
    /// - Returns:
    ///     - returns the instance of `AppError`.
    func decodeData<T:Codable>() throws -> T{
        do{
            let decode = try JSONDecoder().decode(T.self, from: self)
            return decode
        }
        catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
