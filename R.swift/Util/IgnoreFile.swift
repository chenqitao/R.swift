//
//  IgnoreFile.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 01-10-16.
//  Copyright © 2016 Mathijs Kadijk. All rights reserved.
//

import Foundation

class IgnoreFile {
  private let patterns: [String]

  init(ignoreFileURL: URL) throws {
    patterns = try String(contentsOf: ignoreFileURL)
      .components(separatedBy: CharacterSet.newlines)
      .filter(IgnoreFile.isPattern)
  }

  static private func isPattern(potentialPattern: String) -> Bool {
    // Check for empty line
    if potentialPattern.characters.count == 0 { return false }

    // Check for commented line
    if potentialPattern.characters.first == "#" { return false }

    return true
  }

  func match(url: NSURL) -> Bool {
    return patterns
      .map(NSURL.init)
      .any { url == $0 }
  }
}
