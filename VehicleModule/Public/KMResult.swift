//
//  KMResult.swift
//  VehicleModule
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation

public enum KMResult<T> {
    case success(T)
    case failure(Error)

    public var wasSuccess: Bool {
        if case .success = self {
            return true
        } else {
            return false
        }
    }

    public var value: T? {
        if case let .success(val) = self {
            return val
        } else {
            return nil
        }
    }

    public var error: Error? {
        if case let .failure(err) = self {
            return err
        } else {
            return nil
        }
    }
}
