//
//  ApiMockUtils.swift
//  GlobalRadioChallengeTests
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct ApiMockUtils {

    private enum PrivateConstants {
        static let extensionJSON = "json"
    }

    func loadMockRetrieveUUIDJson() -> Data? {
        return loadFileContent(fileName: "MockRetrieveUUIDApiResponse",
                               withExtension: PrivateConstants.extensionJSON)
    }

    func loadMockInitialJson() -> Data? {
        return loadFileContent(fileName: "MockInitialApiResponse",
                               withExtension: PrivateConstants.extensionJSON)
    }

}

private extension ApiMockUtils {

    func loadFileContent(fileName: String, withExtension ext: String) -> Data? {
        do {
            let bundle = Bundle(for: GlobalRadioChallengeTests.self)
            guard let filePathURL = bundle.url(forResource: fileName, withExtension: ext) else {
                return .none
            }
            return try Data(contentsOf: filePathURL)
        } catch {
            return .none
        }
    }

}
