//
//  Navigator.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 15/10/23.
//

import Foundation

enum Routes {
    case detail
}

protocol NavigatorDelegate {
    func navigate(_ routes: Routes)
}
