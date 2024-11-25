//
//  OnboardingView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/25/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var path = PathModel()
    
    var body: some View {
        //todo로 이동
        NavigationStack(path: $path.paths) {
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(for: PathType.self) { pathType in
                    switch pathType {
                    case .homeView:
                        ContentView()
//                            .navigationBarBackButtonHidden(true)
                    case .todoView:
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                    case .memoView:
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
        .environmentObject(path)
    }
}

private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartButtonView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(onboardingViewModel: OnboardingViewModel, selectedIndex: Int = 0) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, content in
                OnboardingCellView(onboardingContent: content)
                    .tag(index)
            }
        }
        .tabViewStyle(.page)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(
            selectedIndex % 2 == 0 ? .customSky : .customBackgroundGreen
        )
        .clipped()
    }
}

private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileNAme)
                .resizable()
                .scaledToFit()
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: 46)
                
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent.subtitle)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            .background(.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

private struct StartButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        Button(action: {
            pathModel.paths.append(.homeView)
        }) {
            HStack {
                Text("시작하기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.customGreen)
                
                Image("rightArrow")
            }
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    OnboardingView()
}
