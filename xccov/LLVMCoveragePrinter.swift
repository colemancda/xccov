//
//  LLVMCoveragePrinter.swift
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

class LLVMCoveragePrinter {

    init() {
    }

    func printOut(jsonFile: Data) {
        // JSONのパースに失敗した場合は処理終了
        let json: Dictionary<String,Any>
        do {
            json = try JSONSerialization.jsonObject(with: jsonFile, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
        } catch {
            print("\(error)")
            return
        }

        self.parse(json: json)
    }


    /// JSONファイルから既定のフォーマットに整形して出力します
    ///
    /// - Parameter filePath: instrprof file path.
    func printOut(filePath: String) {
        // ファイルが見つからない場合は処理終了
        let manager: FileManager = FileManager.default
        guard manager.fileExists(atPath: filePath) else {
            return
        }

        // URLとして成立していない場合は処理終了
        let fileURL: URL = URL(fileURLWithPath: filePath)
        guard fileURL.isFileURL else {
            return
        }

        // 読み込みに失敗した場合は処理終了
        let jsonFile = try? Data(contentsOf: fileURL)
        guard jsonFile != nil else {
            return
        }

        // JSONのパースに失敗した場合は処理終了
        let json: Dictionary<String,Any>
        do {
            json = try JSONSerialization.jsonObject(with: jsonFile!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
        } catch {
            print("\(error)")
            return
        }

        self.parse(json: json)
    }

    private func parse(json: Dictionary<String,Any>) {
        // /data
        let idealRootObject: [Any] = json["data"] as! [Any]
        let data: Dictionary<String,Any> = idealRootObject[0] as! Dictionary<String,Any>

        // /data/totals
        let totals: Dictionary<String,Any> = data["totals"] as! Dictionary<String,Any>

        // /data/totals/regions
        let totalRegions: Dictionary<String,Any> = totals["regions"] as! Dictionary<String,Any>

        // /data/totals/regions/percent
        let totalPercent: Double = totalRegions["percent"] as! Double
        print("Total: \(totalPercent)%")

        // /data/files
        let files: [Any] = data["files"] as! [Any]

        let _ = files.map { (data: Any) in
            let file: Dictionary<String,Any> = data as! Dictionary<String,Any>
            // /data/files/{a file}/filename
            let fileName: String = file["filename"] as! String

            // /data/files/{a file}/summary
            let summary: Dictionary<String,Any> = file["summary"] as! Dictionary<String,Any>

            // /data/files/{a file}/summary/regions
            let regions: Dictionary<String,Any> = summary["regions"] as! Dictionary<String,Any>

            // /data/files/{a file}/summary/regions/percent
            let percent: Double = regions["percent"] as! Double

            print("\(fileName): \(percent)%")
        }
    }
}
