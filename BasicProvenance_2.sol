pragma solidity ^0.8.0;

contract BasicProvenance
{
    //Set of States
    enum StateType { Created, InTransit, Completed }
    
    //List of properties
    StateType public State;
    address public InitiatingCounterparty;
    address public Counterparty;
    address public PreviousCounterparty;
    address public SupplyChainOwner;
    address public SupplyChainObserver;
    
    constructor(address supplyChainOwner, address supplyChainObserver) public {
        InitiatingCounterparty = msg.sender;
        Counterparty = msg.sender;
        SupplyChainOwner = supplyChainOwner;
        SupplyChainObserver = supplyChainObserver;
        State = StateType.Created;
        assert(State == StateType.Created);
        assert(Counterparty == InitiatingCounterparty);
    }

    function TransferResponsibility(address newCounterparty) public {
        require(Counterparty == msg.sender);
        // require(State != StateType.Completed); error
        
        if (State == StateType.Created) {
            State = StateType.InTransit;
        }
        
        PreviousCounterparty = Counterparty;
        Counterparty = newCounterparty;
        assert(Counterparty == newCounterparty);
        assert(State == StateType.InTransit || State == StateType.Created);
    }

    function Complete() public {
        require(SupplyChainOwner == msg.sender);
        require(State != StateType.Completed);
        
        State = StateType.Completed;
        PreviousCounterparty = Counterparty;
        Counterparty = 0x0000000000000000000000000000000000000000;
        assert(State == StateType.Completed);
    }
}
