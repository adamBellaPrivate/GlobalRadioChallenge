//
//  InitialApiResponse.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

struct InitialApiResponse: Decodable {

    let nextPath: String

    private enum CodingKeys: String, CodingKey {
        case nextPath = "next_path"
    }

}
