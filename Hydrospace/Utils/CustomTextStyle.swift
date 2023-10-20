//
//  CustomTextStyle.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 12/10/23.
//

import SwiftUI

extension Font {
    static let customTitle1Bold = Font.custom("DMSans-Bold", size: 28, relativeTo: .title)
    static let customTitle3 = Font.custom("DMSans-Regular", size: 20, relativeTo: .title3)
    static let customTitle3Bold = Font.custom("DMSans-Bold", size: 20, relativeTo: .title3)
    static let customBody = Font.custom("DMSans-Regular", size: 17, relativeTo: .body)
    static let customBodyBold = Font.custom("DMSans-SemiBold", size: 17, relativeTo: .body)
    static let customCalloutSemiBold = Font.custom("DMSans-SemiBold", size: 16, relativeTo: .callout)
    static let customSubheadline = Font.custom("DMSans-Regular", size: 15, relativeTo: .subheadline)
    static let customSubheadlineBold = Font.custom("DMSans-SemiBold", size: 15, relativeTo: .subheadline)
    static let customFootnoteRegular = Font.custom("DMSans-Regular", size: 13, relativeTo: .footnote)
    static let customCaption1 = Font.custom("DMSans-Regular", size: 12, relativeTo: .caption)
}
