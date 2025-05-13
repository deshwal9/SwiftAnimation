//
//  AccordionView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 20/02/25.
//
import SwiftUI


public struct listItem2: Identifiable,Hashable {
  public var id = UUID()
    var title: String
    var description: String
  public init(id: UUID = UUID(), title: String, description: String) {
    self.id = id
    self.title = title
    self.description = description
  }
}
public struct AccordionView: View {
  @State var listData: [listItem2]
  @State var selectedcell: Set<listItem2> = []
  public  init(listData: [listItem2] = []) {
    self.listData = listData
  }
  
  public var body: some View {
      ScrollView{
          ForEach(listData) { item in
            ContentCellNew(item: item, expedable: selectedcell.contains(item))
                  .modifier(ScrollCell())
                  .onTapGesture {
                      if selectedcell.contains(item) {
                          selectedcell.remove(item)
                      }else{
                          selectedcell.insert(item)
                      }
                  }.animation(.easeIn(duration: 0.3))
                   .padding(.vertical, 2)
                 
          }
      }
    }
}
struct ContentCellNew:View {
    let item: listItem2
    var expedable: Bool
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Text(item.title)
                        .font(.headline)
                        .padding(.leading, 10)
                    Spacer()
                    Image(systemName: "plus")
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .rotationEffect(.degrees(expedable ? 45 : 0))
                        .animation(.easeOut(duration: 0.3), value: expedable)
//                        .onTapGesture {
//                            withAnimation(.easeInOut(duration: 1)) {
//                                expedable.toggle() // change
//                            }
//                        }
                }
                if expedable{
                    VStack(alignment: .leading) {
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.leading, 100)
                            .padding(.top, 5)
                    }
                }
            }
            Spacer()
        }.contentShape(Rectangle())
    }
}

#Preview {
  let discription: String = "Born in the Principality of Monaco on 16th October 1997, Charles Leclerc began racing karts at the age of five. In 2011, he won the CIK-FI KF3 World Cup and the CIK-FIA Academy Trophy. in 2012, he was WSK Champion and in 2013, he finished runner-up in the European and Under 18 class with Fortec Motorsport. One year later, still with Fortec, he took the runner-up spot in the ALPS Championship."
   var listData: [listItem2] = [
    listItem2(title: "Title 1", description: discription),
    listItem2(title: "Title 2", description: discription),
    listItem2(title: "Title 3", description: discription),
    listItem2(title: "Title 4", description: discription)]
  AccordionView(listData: listData)
}
