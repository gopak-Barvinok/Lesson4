import "@stdlib/deploy";

message Deposit {
    amount: Int as uint32;
}

message Withdraw {
    amount: Int as uint32;
    target: Address;
}

contract Fund with Deployable {
    
    balance: Int as uint256;

    init() {
        self.balance = 10;
    }

    receive() {
        throw(111);
    }

    receive(msg: Deposit) {
        self.balance = self.balance + msg.amount;
    }

    bounced(src: Deposit) {
        self.balance = self.balance + src.amount;
    }

    receive(msg: Withdraw) {
        require(self.balance >= msg.amount, "There isn't such balance on contract");
        self.balance = self.balance - msg.amount;
        send(SendParameters{
            to: msg.target,
            value: 0,
            mode: SendRemainingValue + SendIgnoreErrors,
            body: Deposit{amount: msg.amount}.toCell()
        });
    }

    get fun balance(): Int {
        return self.balance;
    }
}
