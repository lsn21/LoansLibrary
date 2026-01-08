//
//  Constants.swift
//  LoansHelpers
//
//  Created by Siarhei Lukyanau on 31.10.25.
//

import Foundation
import UIKit

public let widthScreen: CGFloat = UIScreen.main.bounds.width
public let heightScreen: CGFloat = UIScreen.main.bounds.height
public let aspectRatio: CGFloat = UIScreen.main.bounds.width / UIScreen.main.bounds.height
public let aspect: CGFloat = UIScreen.main.bounds.width / 393

public let iPad: Bool = aspectRatio > 0.5 ? true : false
