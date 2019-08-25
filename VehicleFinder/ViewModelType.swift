//
//  ViewModelType.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

protocol ViewModelBindable {

    associatedtype ViewModel: ViewModelType

    var disposeBag: DisposeBag? { get }
    func bind(to viewModel: ViewModel)
}
