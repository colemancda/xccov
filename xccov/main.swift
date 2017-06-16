//
//  main.swift
//  xccov
//
//  Copyright 2017 Hiroaki ENDOH
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

let exePath: URL = URL.init(fileURLWithPath: CommandLine.arguments[0])
let productName: String = exePath.lastPathComponent
var arguments = CommandLine.arguments.suffix(from: 1)

let stdout: FileHandle = FileHandle.standardOutput

if (arguments.contains("-v") || arguments.contains("--version")) {
    print("\(productName) version 0.1")
    exit(EXIT_SUCCESS)
}

if (arguments.contains("-h") || arguments.contains("--help")) {
    let strings: [String] = [
        "Usage: \(productName) [-f | --filePath]",
        "       -f --filePath  JSON file path",
        "" // これがないと末尾に%と出てしまうので、意図的に入れている
    ]

    if let data = strings.joined(separator:"\n").data(using: String.Encoding.utf8) {
        stdout.write(data)
    }

    exit(EXIT_SUCCESS)
}

if !(arguments.contains("-f") || arguments.contains("--filePath")) {
    print("Error -f or --filePath is required.")
    exit(EXIT_FAILURE)
} else {
    let filePath: String = arguments[2]

    let printer: LLVMCoveragePrinter = LLVMCoveragePrinter()
    printer.printOut(filePath: filePath)
}
