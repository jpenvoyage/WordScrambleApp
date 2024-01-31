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
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingError = false

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
        
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMsg)
        }
        .onSubmit {
            addNewWord()
        }
    }
    
    func addNewWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            errorAlert (title: "Word used already", message: "Be more original!")
            return
        }
        
       // guard isPossible(word: answer) else {
         //   errorAlert (title: "Word not possible", message: "You cna't spell that //word from \(rootWord)")
            //return
        //}
        
        guard isReal(word: answer) else {
            errorAlert (title: "no no no", message: "nonono")
            return
        }
        
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
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        // how to check for mispelled words using UITextChecker
        // step 1 create an instance of UITextChecker
        let checker = UITextChecker()
        // step 2 tell the checker how much of our string we want to check
        let range = NSRange(location: 0, length: word.utf16.count)
        // step 3 ask our checker where it found any mispellings
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "pt")
        // step 4
        return misspelledRange.location == NSNotFound
    }
    
    func errorAlert (title: String, message: String) {
        errorTitle = title
        errorMsg = message
        showingError = true
    }
    
    
}

#Preview {
    ContentView()
}
