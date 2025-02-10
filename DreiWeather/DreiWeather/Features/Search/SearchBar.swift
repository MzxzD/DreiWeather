import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("search_bar", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .onSubmit(onSearch)
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
    }
} 
