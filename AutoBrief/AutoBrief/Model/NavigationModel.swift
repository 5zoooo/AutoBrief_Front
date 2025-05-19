//
//  SwiftUIView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//
import Foundation


public enum StackViewType {
    case Record
    case Upload
    case Template
    case FileType
    case Loading
    case Result
}

class PathManager: ObservableObject {
    @Published var path: [StackViewType] = []
}
