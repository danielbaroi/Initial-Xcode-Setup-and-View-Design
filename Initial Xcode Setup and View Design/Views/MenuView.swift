import SwiftUI

struct MenuView: View {
    var body: some View {
        TabView {
            HomeView()
                .background(Color(red: 1.0, green: 1.0, blue: 0.8))
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Order Screen")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Order")
                }
            
            Text("Rewards Screen")
                .tabItem {
                    Image(systemName: "gift")
                    Text("Rewards")
                }
            
            Text("More Screen")
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }
    }
}

struct HomeView: View {
    @State private var boxHeight: CGFloat = 0.75 // Start with 75% screen height for the video placeholder

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Video placeholder box
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: geometry.size.height * boxHeight) // Dynamically sized
                        .padding(.horizontal, -20)
                        .padding(.vertical, -30)
                        .animation(.easeInOut, value: boxHeight)

                    // Cookie of the Month Section for Strawberry Cookie
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Cookie of the Month")
                            .font(.system(size: 35, weight: .bold))
                            .padding(.horizontal, -5)
                            .padding(.vertical, 10)
                        
                        // HStack for Strawberry Cookie
                        HStack {
                            /*
                            Image("strawberry cookie no background")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200) // Make the cookie image bigger
                                .offset(x: -30) // Move the image slightly out of the left side
                                .padding(.trailing, -30) // Add some negative padding to make it come out more
                            */

                            VStack(alignment: .leading) {
                                Text("Strawberry")
                                    .font(.system(size: 25, weight: .bold))
                                Text("Cookie")
                                    .font(.system(size: 25, weight: .bold))
                                
                                Text("Learn More")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                    .padding(.top, 5)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        // Cookie of the Month Section for Confetti Cookie
                        HStack {
                            /*
                            Image("confetti cookie no background")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200) // Make the cookie image bigger
                                .offset(x: -30) // Move the image slightly out of the left side
                                .padding(.trailing, -30) // Add some negative padding to make it come out more
                            */
                            
                            VStack(alignment: .leading) {
                                Text("Confetti")
                                    .font(.system(size: 25, weight: .bold))
                                Text("Cookie")
                                    .font(.system(size: 25, weight: .bold))
                                
                                Text("Learn More")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                    .padding(.top, 5)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        // Order Button
                        Button(action: {
                            // Add action here
                        }) {
                            Text("Order Now")
                                .font(.system(size: 20, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20) // Padding for the cookie section
                }
                .padding()
                .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // Background color for scrolling content
                .onAppear {
                    boxHeight = 0.75 // Set initial box height to 75%
                }
                .onChange(of: geometry.frame(in: .global).minY) { minY in
                    let scrollThreshold: CGFloat = -150 // Adjust the shrinking threshold
                    if minY < scrollThreshold {
                        boxHeight = 0.2 // When scrolled down, shrink to 20% of screen height
                    } else {
                        boxHeight = 0.75 // When at the top, stay at 75% of screen height
                    }
                }
            }
            .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // Overall background color
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MenuView()
}
