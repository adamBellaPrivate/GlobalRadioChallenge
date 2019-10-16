//
//  ErrorWorker.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct ErrorWorker {
    enum ApiError: Error {
        case invalidApiURL
        case invalidResponse
        case businessError(Int)
        case unknown
    }

    func process(error err: Error) -> String {
        guard let apiError = err as? ApiError else { return err.localizedDescription }

        switch apiError {
        case .invalidResponse,
             .invalidApiURL:
            return "general_error".localized
        case .businessError(let statusCode):
            return String(format: "business_error".localized, statusCode)
        case .unknown:
            return "unknown_error".localized
        }
    }
}
