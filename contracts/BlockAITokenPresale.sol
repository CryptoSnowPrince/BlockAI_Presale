//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        _transferOwnership(_msgSender());
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

interface IPriceExt {
    function latestAnswer() external view returns (int256 answer);
}

contract BlockAITokenPresale is Ownable {
    IERC20 public saleTokenAddress;

    uint256 public priceInCAU;

    uint256 public dDecimalsCAU;

    uint256 public startTime;
    uint256 public endTime;

    uint256 public totalBuyAmount;
    uint256 public totalClaimAmount;
    uint256 public totalCAUAmount;

    mapping(address => uint256) public buyAmount;
    mapping(address => uint256) public claimAmount;
    mapping(address => uint256) public userPaidInCAU; // usdAmount as price feed decimals

    event Purchase(address indexed _from, address indexed _to, uint256 _amount);
    event Claim(address indexed _from, address indexed _to, uint256 _amount);
    event SetStartTime(uint256 _time);
    event SetEndTime(uint256 _time);
    event WithdrawAll(address indexed addr, uint256 amount);

    receive() external payable {}
    fallback() external payable {}

    constructor() {
        saleTokenAddress = IERC20(0x45582d60Ace910e44b89Ee8c8f38913B97f0fA6f); // test Net

        startTime = 1720051200; // Thu Jul 04 2024 00:00:00 GMT+0000
        endTime = 1720137600; // Fri Jul 05 2024 00:00:00 GMT+0000

        priceInCAU = 55;

        dDecimalsCAU = 10 ** 5;
    }

    function buyTokensByETH() external payable {
        require(block.timestamp >= startTime, "Presale is not started yet");
        require(block.timestamp <= endTime, "Presale is ended");

        require(msg.value > 0, "Insufficient ETH amount");

        uint256 cauAmount = msg.value;

        // token amount user want to buy
        uint256 tokenAmount = (cauAmount * dDecimalsCAU) / priceInCAU;
        buyAmount[msg.sender] += tokenAmount;

        totalBuyAmount += tokenAmount;
        totalCAUAmount += msg.value;

        // add USD user bought
        userPaidInCAU[msg.sender] += cauAmount;

        emit Purchase(address(this), msg.sender, tokenAmount);
    }

    function claimToken(uint256 tokenAmount) external {
        require(block.timestamp > endTime, "Claim is not started yet");

        uint256 cAmount = buyAmount[msg.sender] - claimAmount[msg.sender];
        require(cAmount >= tokenAmount, "Insufficient token to claim");

        claimAmount[msg.sender] += tokenAmount;

        totalClaimAmount += tokenAmount;

        // transfer token to user
        saleTokenAddress.transfer(msg.sender, tokenAmount);

        emit Claim(address(this), msg.sender, tokenAmount);
    }

    function withdrawAll(address to) external onlyOwner {
        require(block.timestamp > endTime);

        uint256 CAUbalance = address(this).balance;

        if (CAUbalance > 0) {
            safeTransferCAU(to, CAUbalance);
        }

        emit WithdrawAll(to, CAUbalance);
    }

    function withdrawToken(address to) public onlyOwner returns (bool) {
        require(block.timestamp > endTime);

        uint256 balance = saleTokenAddress.balanceOf(address(this));
        return saleTokenAddress.transfer(to, balance);
    }

    function setStartTime(uint256 _startTime) public onlyOwner {
        startTime = _startTime;
    }

    function setEndTime(uint256 _endTime) public onlyOwner {
        endTime = _endTime;
    }

    function setSaleTokenAddress(address _address) public onlyOwner {
        saleTokenAddress = IERC20(_address);
    }

    function setPriceInCAU(uint256 _priceInCAU) public onlyOwner {
        priceInCAU = _priceInCAU;
    }

    function setDeltaDecimalsCAU(uint256 _dDecimalsCAU) public onlyOwner {
        dDecimalsCAU = _dDecimalsCAU;
    }

    function safeTransferCAU(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, "ETH transfer failed");
    }
}