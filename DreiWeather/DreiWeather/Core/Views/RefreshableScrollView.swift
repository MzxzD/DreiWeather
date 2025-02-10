import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    let content: () -> Content
    let onRefresh: () async -> Void
    
    @State private var isRefreshing = false
    @State private var threshold: CGFloat = 200
    @State private var offset: CGFloat = 0
    @State private var shouldRefresh = false
    
    init(
        onRefresh: @escaping () async -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.onRefresh = onRefresh
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            content()
                .overlay {
                    MovingView(offset: offset, isRefreshing: isRefreshing)
                        .frame(height: 200)
                }
                .redacted(reason: !isRefreshing ? [] : .placeholder)
        }
        .coordinateSpace(name: "pullToRefresh")
        .overlay(alignment: .top) {
            GeometryReader { geo -> Color in
                let offset = geo.frame(in: .named("pullToRefresh")).minY
                
                if offset > threshold && !shouldRefresh && !isRefreshing {
                    Task { @MainActor in
                        shouldRefresh = true
                    }
                    
                }
                
                if offset < threshold && shouldRefresh && !isRefreshing {
                    Task { @MainActor in
                        shouldRefresh = false
                        isRefreshing = true
                        await onRefresh()
                        isRefreshing = false
                    }
                }
                
                DispatchQueue.main.async {
                    self.offset = offset
                }
                
                return Color.clear
            }
            .frame(height: 0)
        }
    }
}

private struct MovingView: View {
    let offset: CGFloat
    let isRefreshing: Bool
    
    var body: some View {
        if offset > 98 || isRefreshing {
            ProgressView()
                .tint(.black)
                .progressViewStyle(.circular)
                .transition(.opacity.animation(.easeInOut))
                .scaleEffect(3)
        }
    }
}
