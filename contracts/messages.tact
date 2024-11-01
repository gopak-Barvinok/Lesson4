import "@stdlib/deploy";

message Add {
    amount: Int as uint32;
}

message Substract {
    amount: Int as uint32;
}

message MultiMath {
    add: Int as uint32;
    substract: Int as uint32;
    multiply: Int as uint32;
}

struct Operations {
    add: Int as uint32;
    substract: Int as uint32;
    multiply: Int as uint32; 
}

contract Messages with Deployable {
    val: Int as int64;

    init() {
        self.val = 0;
    }

    receive() {
        
    }

    receive(msg: Add) {
        self.val = self.val + msg.amount;
    }

    receive(msg: Substract) {
        self.val = self.val - msg.amount;
    }

    receive(msg: MultiMath) {
        self.val = self.val + msg.add;
        self.val = self.val - msg.substract;
        self.val = self.val * msg.multiply;
    }

    receive("increment") {
        self.val = self.val + 1;
    }

    receive("decrement") {
        self.val = self.val - 1;
    }

    receive(msg: String) {

    }

    receive(msg: Slice) {
         
    }

    get fun value(): Int {
        return self.val;
    }
}
