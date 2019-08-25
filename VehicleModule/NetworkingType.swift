//
//  NetworkingType.swift
//  VehicleModule
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import RxSwift

protocol NetworkingType {

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkingType {
}

