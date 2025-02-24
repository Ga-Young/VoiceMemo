//
//  TodoListView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/28/24.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if todoListViewModel.getTodosCount() != 0 {
                    CustomNavigationBar(isDisplayLeftButton: false,
                                        rightButtonAction: todoListViewModel.navigationBarRightButtonTapped,
                                        rightButtonType: todoListViewModel.navigationBarRightButtonMode)
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                    .padding(.top, 20)
                
                if todoListViewModel.getTodosCount() == 0 {
                    AnnouncementView()
                    
                } else {
                    TodoListContentView()
                        .padding(.top, 20)
                }
            }
            
            WriteTodoButtonView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert("To do List \(todoListViewModel.removeTodoCount)개 삭제하시겠습니까?",
               isPresented: $todoListViewModel.isDisplayRemoveAlert) {
            Button("삭제", role: .destructive) {
                todoListViewModel.removeButtonTapped()
            }
            Button("취소", role: .cancel) {}
        }
        .onChange(
            of: todoListViewModel.todos,
            perform: { todos in
                homeViewModel.setTodosCount(todos.count)
            }
        )
    }
}

private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if todoListViewModel.getTodosCount() == 0 {
                Text("To do List를\n추가해보세요")
                
            } else {
                Text("To do List \(todoListViewModel.getTodosCount())개가\n있습니다.")
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15){
            Spacer()
            Image("pencil")
                .renderingMode(.template)
            Text("\"아침 10시 운동\"")
            Text("\"지원이랑 점심 약속\"")
            Text("\"5시까지 메일 보내기\"")
            Text("\"오후 6시 여은이 만나기\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

private struct TodoListContentView: View {
    @EnvironmentObject var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("할일 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        TodoCellView(todo: todo)
                    }
                }
            }
        }
    }
}

private struct TodoCellView: View {
    @EnvironmentObject var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        todo: Todo
    ) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditMode {
                    Button {
                        todoListViewModel.selectedBoxTapped(todo)
                        
                    } label: {
                        todo.isSelected ? Image("check_fill") : Image("check_empty")
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundColor(todo.isSelected ? .customGrayIcon : .customBlack)
                        .strikethrough(todo.isSelected)
                    Text(todo.convertedDate)
                        .font(.system(size: 12))
                        .foregroundColor(.customGrayIcon)
                }
                
                Spacer()
                
                if todoListViewModel.isEditMode {
                    Button {
                        isRemoveSelected.toggle()
                        todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                        
                    } label: {
                        isRemoveSelected ? Image("check_fill") : Image("check_empty")
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Rectangle()
                .fill(.customGray0)
                .frame(height: 1)
        }
    }
}

private struct WriteTodoButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    pathModel.paths.append(.todoView)
                    
                } label: {
                    Image("write_btn")
                }
            }
        }
    }
}
#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
