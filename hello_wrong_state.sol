pragma solidity >=0.4.25 <0.6.0;
contract HelloBlockchain
{
     //Set of States
    enum StateType { Request, Respond}

    //List of properties
    StateType public  State;
    address public  Requestor;
    address public  Responder;

    string public RequestMessage;
    string public ResponseMessage;

    // constructor function
    constructor(string memory message) public
    {
        Requestor = msg.sender;
        RequestMessage = message;
        State = StateType.Request;
    }

    
    function SendRequest(string memory requestMessage) public{
        require(Requestor == msg.sender);
        RequestMessage = requestMessage;
        State = StateType.Request;
        assert(State == StateType.Respond);
        // assert(RequestMessage == requestMessage);
    }

    // call this function to send a response
    function SendResponse(string memory responseMessage) public
    {
        Responder = msg.sender;

        // call ContractUpdated() to record this action
        ResponseMessage = responseMessage;
        State = StateType.Respond;
    }
}