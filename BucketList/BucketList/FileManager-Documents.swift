//
//  FileManager-Documents.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-17.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

extension FileManager {
    func loadDocument(_ filename: String) -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        if self.fileExists(atPath: url.path) {
            do {
                return try Data(contentsOf: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return nil
    }
    
    func writeDocument(_ filename: String, withData data: Data, options: Data.WritingOptions = []) {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: url, options: options)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        guard let documentsDirectory = self.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get documents directory")
        }
        
        return documentsDirectory
    }
}
