//
//  TodoView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/9/24.
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                leftButtonAction: {
                    pathModel.paths.removeLast()
                },
                rightButtonAction: {
                    todoListViewModel.addTodo(
                        .init(title: todoViewModel.title,
                              time: todoViewModel.time,
                              day: todoViewModel.day,
                              isSelected: false
                             )
                    )
                    pathModel.paths.removeLast()
                },
                rightButtonType: .create
            )
            
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 20)
            
            TodoTitleView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            
            SelectTimeView(todoViewModel: todoViewModel)
            
            SelectDayView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            
            Spacer()
        }
    }
}

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("To do list를\n추가해 보세요.")
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

private struct TodoTitleView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        TextField("제목을 입력하세요.", text: $todoViewModel.title)
    }
}

private struct SelectTimeView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
            
            DatePicker(
                "",
                selection: $todoViewModel.time,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}

private struct SelectDayView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("날짜")
                    .foregroundColor(.customGrayIcon)
                
                Spacer()
            }
            
            HStack {
                Button {
                    todoViewModel.setIsDisplayCalendar(true
                    )
                } label: {
                    Text("\(todoViewModel.day.formattedDay)")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.customGreen)
                }
                .popover(isPresented: $todoViewModel.isDisplayCalendar) {
                    DatePicker(
                        "",
                        selection: $todoViewModel.day,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .onChange(of: todoViewModel.day) { _ in
                        todoViewModel.setIsDisplayCalendar(false)
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    TodoView()
}
