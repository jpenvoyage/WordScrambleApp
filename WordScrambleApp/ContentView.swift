//
//  ContentView.swift
//  WordScrambleApp
//
//  Created by Joao Leal on 31/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newWord = ""
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                   TextField("Enter your word", text: $newWord)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                    Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
        }
        .onAppear(perform: {
            startGame()
        })
        
        .onSubmit {
            addNewWord()
        }
    }
    
    func addNewWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame () {
        if let startWord = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let rightWord = try? String(contentsOf: startWord) {
                let allWords = rightWord.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "dsada"
           return
            }
           
        }
        fatalError("aaaaaaa eerro")
    }
}

#Preview {
    ContentView()
}
