import SwiftUI

struct LocationBadge: View {    
    var body: some View {
        Label("current_location", systemImage: "location.fill")
            .font(.caption)
            .padding(Constants.Layout.smallPadding)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .padding(Constants.Layout.smallPadding)
    }
} 
