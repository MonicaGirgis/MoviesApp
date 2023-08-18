//
//  ViewModelDelegates.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

protocol ViewModelDelegates {
    func autoUpdateView()
    func failedWithError(_ err: String)
    func loaderIsHidden(_ isHidden: Bool)
    func insertNewRows(_ initialIndex: Int, _ endIndex: Int, _ section: Int)
}

extension ViewModelDelegates {
    func dismissView() {
        print("Dismiss")
    }
}
