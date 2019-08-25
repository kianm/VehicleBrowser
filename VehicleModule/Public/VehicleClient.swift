//
//  VehicleClient.swift
//  VehicleModule
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import RxSwift

public final class VehicleClient: VehicleClientType, NetworkingInjected {

    public func getVehicles() -> Observable<KMResult<Vehicles>> {
        var comps = URLComponents(string: Environment.apiURL)
        comps?.path += Environment.vehiclesEndpoint
        guard let url = comps?.url else {
            fatalError("Malformed or invalid URL")
        }
        return asyncDataTask(urlrequest: request(url))
            .map {[unowned self] (result: KMResult<Data>) -> KMResult<Vehicles> in
                switch result {
                case .success(let data):
                    return self.decoder(data: data)
                case .failure(let error):
                    return .failure(error)
                }
        }
    }

    private func decoder(data: Data) -> KMResult<Vehicles> {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let result: Vehicles = try? decoder.decode(Vehicles.self, from: data) {
            return .success(result)
        } else {
            return .failure(KMErrorType.encodingError)
        }
    }

    private func asyncDataTask(urlrequest: URLRequest) -> Observable<KMResult<Data>> {
        let subject = ReplaySubject<KMResult<Data>>.create(bufferSize: 1)
        let dataTask = networking.dataTask(with: urlrequest) {
            if let error = $2 {
                subject.onNext(KMResult<Data>.failure(error))
                return
            }
            if let data = $0 {
                subject.onNext(KMResult<Data>.success(data))
                return
            }
            subject.onNext(KMResult<Data>.failure(KMErrorType.serverError(500)))
        }
        dataTask.resume()
        return subject
    }

    private func request(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers()
        return request
    }

    private func headers() -> [String: String] {
        return [
            "User-Agent": "VehicleModule iOS v1.0",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Language": "en",
            "Accept-Encoding": ""
        ]
    }

    public init() {
        
    }
}
