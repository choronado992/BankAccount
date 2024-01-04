class VirtualBankSystem{
    var accountType = ""
    var isOpened = true
    
    func greet(){
        print("Welcome to your virtual bank system.")
    }
    
    func onboardCustomerAccountOpening(){
        print("What kind of account would you like to open?")
        print("1. Debit account")
        print("2. Credit account")
    }
    
    func makeAccount(numberPadKey: Int){
        print("The selected option is \(numberPadKey)")
        switch numberPadKey {
            case 1: accountType = "debit"
            case 2: accountType = "credit"
            default: print("Invalid input: \(numberPadKey)")
        }
        print("You have opened a \(accountType) account.")
    }
    
    func moneyTransfer(transferType: String, transferAmount: Int, bankAccount: inout BankAccount){
        switch transferType {
            case "withdraw":
                if accountType == "credit"{
                    bankAccount.creditWithdraw(transferAmount)
                }else if accountType == "debit"{
                    bankAccount.debitWithdraw(transferAmount)
                }
            case "deposit":
                if accountType == "credit"{
                    bankAccount.creditDeposit(transferAmount)
                }else if accountType == "deposit"{
                    bankAccount.debitDeposit(transferAmount)
                }
            default: break
        }
    }
    
    func checkBalance(bankAccount: BankAccount){
        switch accountType {
            case "credit": print(bankAccount.creditBalanceInfo)
            case "debit": print(bankAccount.debitBalanceInfo)
            default: break
        }
    }
}

class BankAccount{
    var debitBalance = 0
    var creditBalance = 0
    let creditLimit = 100
    var debitBalanceInfo: String{
        "Debit balance: $\(debitBalance)."
    }
    var creditBalanceInfo: String{
        "Available credit: $\(availableCredit)."
    }
    var availableCredit: Int{
        creditLimit - creditBalance
    }
    
    func debitDeposit(_ amount: Int){
        debitBalance += amount
        print("Deposited $\(amount). \(debitBalanceInfo)")
    }
    
    func creditDeposit(_ amount: Int){
        creditBalance -= amount
        print("Credit $\(amount). \(creditBalanceInfo)")
        if creditBalance == 0{
            print("Paid off credit balance.")
        }else if creditBalance < 0{
            print("Overpaid credit balance.")
        }
    }
    
    func debitWithdraw(_ amount: Int){
        if amount > debitBalance{
            print("Insufficient funds to withdraw $\(amount). \(debitBalanceInfo)")
        }else{
            debitBalance -= amount
            print("Debit withdraw: $\(amount). \(debitBalanceInfo)")
        }
    }
    
    func creditWithdraw(_ amount: Int){
        if amount > availableCredit{
            print("Insufficient credit to withdraw $\(amount). \(creditBalanceInfo)")
        }else{
            creditBalance += amount
            print("Credit withdraw: $\(amount). \(creditBalanceInfo)")
        }
    }
}

var virtualBankSystem = VirtualBankSystem()
virtualBankSystem.greet()

repeat {
    virtualBankSystem.onboardCustomerAccountOpening()
    let numberPadKey = Int.random(in: 1...2)
    virtualBankSystem.makeAccount(numberPadKey: numberPadKey)
} while virtualBankSystem.accountType == ""

let transferAmount = 50
var bankAccount = BankAccount()

repeat{
    print("")
    print("What would you like to do? ")
    print("1. Check bank account")
    print("2. Withdraw money")
    print("3. Deposit money")
    print("4. Close the system")
    
    let option = Int.random(in: 1...4)
    print("You have selected \(option)")
    
    switch option {
        case 1: virtualBankSystem.checkBalance(bankAccount: bankAccount)
        case 2: virtualBankSystem.moneyTransfer(transferType: "withdraw", transferAmount: transferAmount, bankAccount: &bankAccount)
        case 3: virtualBankSystem.moneyTransfer(transferType: "deposit", transferAmount: transferAmount, bankAccount: &bankAccount)
        case 4:
            print("The system is closed")
            virtualBankSystem.isOpened = false
        default: break
    }
}while virtualBankSystem.isOpened

