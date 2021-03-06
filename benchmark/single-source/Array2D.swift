//===--- Array2D.swift ----------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import TestsUtils

public let Array2D = BenchmarkInfo(
  name: "Array2D",
  runFunction: run_Array2D,
  tags: [.validation, .api, .Array],
  setUpFunction: { blackHole(inputArray) },
  tearDownFunction: { inputArray = nil })

var inputArray: [[Int]]! = {
  var A: [[Int]] = []
  A.reserveCapacity(1024)
  for _ in 0 ..< 1024 {
    A.append(Array(0 ..< 1024))
  }
  return A
}()

@inline(never)
func modifyArray(_ A: inout [[Int]], _ N: Int) {
  for _ in 0..<N {
    for i in 0 ..< 1024 {
      for y in 0 ..< 1024 {
        A[i][y] = A[i][y] + 1
        A[i][y] = A[i][y] - 1
      }
    }
  }
}

@inline(never)
public func run_Array2D(_ N: Int) {
  modifyArray(&inputArray, N)
}
