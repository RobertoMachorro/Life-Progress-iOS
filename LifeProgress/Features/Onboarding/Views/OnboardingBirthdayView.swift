//
//  OnboardingBirthdayView.swift
//  Life Progress - Calendar
//
//  Created by Bartosz Król on 03/05/2023.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingBirthdayView: View {
    
    @Environment(\.theme) var theme
    
    let store: OnboardingStore
    
    var body: some View {
        WithViewStore(self.store.stateless) { viewStore in
            VStack {
                List {
                    Section {
                        VStack(spacing: 24) {
                            HStack {
                                Spacer()
                                Image(systemName: "birthday.cake.fill")
                                    .font(.system(size: 72))
                                    .foregroundColor(theme.color)
                                Spacer()
                            }
                            
                            Text("Select Your Birthday")
                                .font(.system(size: 32, weight: .bold))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        BirthdayView(
                            store: self.store.scope(
                                state: \.birthday,
                                action: OnboardingReducer.Action.birthday
                            )
                        )
                    } footer: {
                        Text("This information allows us to customize your experience and deliver relevant insights. Your data is safe and will not be shared with anyone.")
                    }
                }
                
                Button {
                    viewStore.send(.continueButtonTapped)
                } label: {
                    Text("Continue")
                        .font(.headline)
                }
                .tint(theme.color)
                .padding()
            }
        }
    }
}

// MARK: - Previews

struct OnboardingBirthdayView_Previews: PreviewProvider {
    
    static var previews: some View {
        let store = Store<OnboardingReducer.State, OnboardingReducer.Action>(
            initialState: OnboardingReducer.State(),
            reducer: OnboardingReducer()
        )
        OnboardingBirthdayView(store: store)
    }
}
