//
//  MissingInteger.swift
//
//  Created by Harland Harrison on 9/6/24.
//

//  Use Terminal to execute:
//       cd  PATH
//       swift MissingInteger.swift -h

// Solution to the "Missing Integer" example for Codility challenges.
// This solution uses Swift library functions to avoid looping

import Foundation

public func solution(_ ints : inout [Int]) -> Int {
    var positive = ints.map{$0>0 ? $0 : 0}
    positive.append(0) // low scan stop
    let unique = Array(Set(positive))
    var sorted = unique.sorted()
    var test = 0
    var min = 0
    var max = sorted.count-1
    sorted.append(sorted[max]+2) // high scan stop
    // binary search for lowest gap in sequence
    while max>min+3 {
        test = (min+max)/2
        if sorted[test]>test {
            max = test-1 // still max>min
        } else {
            min = test
        }
    }
    // now very close
    test = min
    while sorted[test]==test {
        test = test + 1
    }
    return test
}

func test(_ inRA:[Int]) {
    var testRA = inRA
    print("\(testRA) -> \n  \(solution(&testRA))")
}

var cmdArgs = CommandLine.arguments
var example = [-1,2,-5,6,0,4,-3,9,6,2,1,4,3,9,5,9,7]

// Test example array
if  cmdArgs.count < 2 {
    test(example)
    exit(0)
}

// Help message
if cmdArgs[1].lowercased().hasPrefix("-h") {
    print("MissingInteger.swift - Format:")
    print("   swift MissingInteger.swift [-h] [\"n,n,n\"] ...")
    print("   Example: swift MissingInteger.swift \"1,2,5\" \"-2,1,3,4\"")
    exit(0)
}

// Test arrays in comma separated Command Line Argument strings
for i in 1...cmdArgs.count-1 {
    let str = cmdArgs[i]
    let sRA:[String] = str.split(separator:",").map(String.init)
    let intRA:[Int] =  sRA.map{Int($0) == nil ? 0 : Int($0)! }
    test(intRA)
}

