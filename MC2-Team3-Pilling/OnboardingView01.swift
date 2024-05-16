
import SwiftUI

struct OnboardingView01: View {
    @State private var showingMedicineSheet = false
    
    var body: some View {
        Image("making-plan")
            .resizable()
            .frame(width: 300, height: 300)
        
        // Text
        VStack(alignment: .leading) {
            Text("복용하고 계신 약을 알려주세요!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 2)
            
            Text("설정은 추후에 변경 가능합니다.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }

        
        // Selecting box
        VStack {
            Button(action: {
                self.showingMedicineSheet = true
            }, label: {
                // sfSymbol 부재 : medicine-bottle-one
                HStack {
                    Image(systemName: "pill.circle.fill")
                    Text("약 종류")
                        .font(.title3)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding([.leading, .trailing], 25)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            .padding()
            .sheet(isPresented: $showingMedicineSheet){
                MedicineSheetView()
                    .presentationDetents([.medium])
            }
            
            
            
            Button(action: {}, label: {
                // sfSymbol 부재 : uis-calender
                HStack {
                    Image(systemName: "note")
                    Text("현재 복용 일수")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 25)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            .padding()
            
        }
        
        
        // footer button
        Button(action: {
//            OnboardingView02()
        }, label: {
            Text("다음으로")
                .font(.title3)
                .bold()
        })
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(.customGreen)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.black)
        .padding()
    }
}

#Preview {
    OnboardingView01()
}
