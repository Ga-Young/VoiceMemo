//
//  TodoListViewModel.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/28/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEditMode: Bool
    @Published var removeTodos: [Todo]
    @Published var isDisplayRemoveAlert: Bool
    
    var removeTodoCount: Int {
        removeTodos.count
    }
    var navigationBarRightButtonMode: NavigationButtonType {
        isEditMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [],
        isEditMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditMode = isEditMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveAlert = isDisplayRemoveAlert
    }
}

extension TodoListViewModel {
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(of: todo){
            todos[index].isSelected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    func getTodosCount() -> Int {
        todos.count
    }
    
    func navigationBarRightButtonTapped() {
        if isEditMode {
            if removeTodos.isEmpty {
                isEditMode = false
            } else {
                setIsDisplayRemoveTodoAlert(true)
            }
            
        } else {
            isEditMode = true
        }
    }
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
            
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeButtonTapped() {
        removeTodos.forEach {_ in 
            todos.removeAll(where: { $0.title == $0.title })
        }
        removeTodos.removeAll()
        isEditMode = false
    }
}
