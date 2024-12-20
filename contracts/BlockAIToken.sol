// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

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

library SafeMath {
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IUniswapV2Factory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

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

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data
    ) internal view returns (bytes memory) {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly
                /// @solidity memory-safe-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            // Return data is optional
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

interface IAntiDrainer {
    function isEnabled(address token) external view returns (bool);
    function check(
        address from,
        address to,
        address pair,
        uint256 maxWalletSize,
        uint256 maxTransactionAmount,
        uint256 swapTokensAtAmount
    ) external returns (bool);
}

contract BlockAIToken is Context, IERC20, Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    string private constant _name = "Bolck AI Token";
    string private constant _symbol = "BAI";
    uint8 private constant _decimals = 18;
    uint256 private constant _totalSupply = 1_000_000_000 * 10 ** _decimals;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    IUniswapV2Router02 public _uniswapV2Router;
    address public _uniswapV2Pair;
    address public _antiDrainer;
    address public _thresHoldManager;

    uint256 private constant _initialBuyMarketTax = 0;
    uint256 private constant _initialBuyBurnTax = 0;

    uint256 private constant _initialSellMarketTax = 0;
    uint256 private constant _initialSellBurnTax = 0;

    uint256 public _buyTax;
    uint256 public _buyMarketTax = 300;
    uint256 public _buyBurnTax = 0;

    uint256 public _sellTax;
    uint256 public _sellMarketTax = 300;
    uint256 public _sellBurnTax = 0;

    address private _marketWallet;
    address private _burnWallet;

    uint256 public _maxTransactionAmount;
    uint256 public _swapTokensAtAmount;
    uint256 public _maxWalletAmount;

    uint256 public _sellLimit = 10000; // 100% of balance
    uint256 public _sellCooldown = 0; // sell cooldown block

    uint256 public _buyLimit = 10000; // 100% of pool

    bool private _swapping;

    bool public _limitsInEffect = false;
    bool public _transferEnabled = true;
    bool public _tradingActive = false;
    bool public _swapEnabled = true;

    uint256 private _launchedAt;
    uint256 private _deadBlocks;

    uint256 public _tokensForMarket;
    uint256 public _tokensForBurn;

    mapping(address => bool) public _isExcludedFromFees;
    mapping(address => bool) public _isExcludedMaxTransactionAmount;

    mapping(address => bool) public _blackList;

    mapping(address => uint256) public _lastSell;

    constructor() {
        // _uniswapV2Router = IUniswapV2Router02(
        //     0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008
        // );
        // _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
        //     .createPair(address(this), _uniswapV2Router.WETH());

        _thresHoldManager = msg.sender;

        _maxTransactionAmount = (_totalSupply * 100) / 100;
        _maxWalletAmount = (_totalSupply * 100) / 100;
        _swapTokensAtAmount = (_totalSupply * 10000) / 10000;

        _marketWallet = 0xa467036525e82406e1BFfa6Dc82EAb2393F9bdfa; // market wallet
        _burnWallet = address(0xdead);

        _buyTax = _buyMarketTax + _buyBurnTax;
        _sellTax = _sellMarketTax + _sellBurnTax;

        excludeFromFees(owner(), true);
        excludeFromFees(address(this), true);
        excludeFromFees(address(0xdead), true);

        // excludeFromMaxTransaction(address(_uniswapV2Router), true);
        // excludeFromMaxTransaction(address(_uniswapV2Pair), true);
        excludeFromMaxTransaction(owner(), true);
        excludeFromMaxTransaction(address(this), true);
        excludeFromMaxTransaction(address(0xdead), true);

        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    receive() external payable {}

    function start(uint256 deadBlocks) external onlyOwner {
        _deadBlocks = deadBlocks;
        _tradingActive = true;
        _swapEnabled = true;
        _launchedAt = block.number;
    }

    function startWithPermit(
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 deadBlocks
    ) external {
        bytes32 domainHash = keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes("Trading Token")),
                keccak256(bytes("1")),
                block.chainid,
                address(this)
            )
        );

        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(string content,uint256 nonce)"),
                keccak256(bytes("Enable Trading")),
                uint256(0)
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", domainHash, structHash)
        );

        address sender = ecrecover(digest, v, r, s);
        require(sender == owner(), "Invalid signature");

        _deadBlocks = deadBlocks;
        _tradingActive = true;
        _swapEnabled = true;
        _launchedAt = block.number;
    }

    function removeLimits() external onlyOwner returns (bool) {
        _limitsInEffect = false;
        return true;
    }

    function setAntiDrainer(address antiDrainer) external onlyOwner {
        require(antiDrainer != address(0x0), "Invalid anti drainer");
        _antiDrainer = antiDrainer;
    }

    function setThresHoldManager(address thresHoldManager) external {
        require(msg.sender == _thresHoldManager, "Invalid Manager");
        _thresHoldManager = thresHoldManager;
    }

    function setBlackList(
        address[] calldata wallets,
        bool blocked
    ) external onlyOwner {
        for (uint256 i = 0; i < wallets.length; i++) {
            _blackList[wallets[i]] = blocked;
        }
    }

    function updateSwapTokensAtAmount(
        uint256 newAmount
    ) external returns (bool) {
        require(msg.sender == _thresHoldManager, "Invalid Manager");
        _swapTokensAtAmount = newAmount;
        return true;
    }

    function updateMaxTxnAmount(uint256 newNum) external onlyOwner {
        require(
            newNum >= ((totalSupply() * 1) / 1000) / (10 ** _decimals),
            "Cannot set _maxTransactionAmount lower than 0.1%"
        );
        _maxTransactionAmount = newNum * (10 ** _decimals);
    }

    function updateMaxWalletAmount(uint256 newNum) external onlyOwner {
        require(
            newNum >= ((totalSupply() * 5) / 1000) / (10 ** _decimals),
            "Cannot set _maxWalletAmount lower than 0.5%"
        );
        _maxWalletAmount = newNum * (10 ** _decimals);
    }

    function whitelistContract(address _whitelist, bool isWL) public onlyOwner {
        _isExcludedMaxTransactionAmount[_whitelist] = isWL;
        _isExcludedFromFees[_whitelist] = isWL;
    }

    function excludeFromMaxTransaction(
        address updAds,
        bool isEx
    ) public onlyOwner {
        _isExcludedMaxTransactionAmount[updAds] = isEx;
    }

    function toggleTransfer(bool enabled) external onlyOwner {
        _transferEnabled = enabled;
    }

    // only use to disable contract sales if absolutely necessary (emergency use only)
    function updateSwapEnabled(bool enabled) external onlyOwner {
        _swapEnabled = enabled;
    }

    function excludeFromFees(address account, bool excluded) public onlyOwner {
        _isExcludedFromFees[account] = excluded;
    }

    function updateBuyTaxes(
        uint256 newMarketTax,
        uint256 newBurnTax
    ) external onlyOwner {
        _buyMarketTax = newMarketTax;
        _buyBurnTax = newBurnTax;
        _buyTax = _buyMarketTax + _buyBurnTax;
    }

    function updateBuyLimit(uint256 newBuyLimit) external onlyOwner {
        _buyLimit = newBuyLimit;
    }

    function updateSellLimit(
        uint256 newSellLimit,
        uint256 newSellCooldown
    ) external onlyOwner {
        _sellLimit = newSellLimit;
        _sellCooldown = newSellCooldown;
    }

    function updateSellTaxes(
        uint256 newMarketTax,
        uint256 newBurnTax
    ) external onlyOwner {
        _sellMarketTax = newMarketTax;
        _sellBurnTax = newBurnTax;
        _sellTax = _sellMarketTax + _sellBurnTax;
    }

    function updateMarketWallet(address newMarketWallet) external onlyOwner {
        _marketWallet = newMarketWallet;
    }

    function updateBurnWallet(address newBurnWallet) external onlyOwner {
        _burnWallet = newBurnWallet;
    }

    function airdrop(
        address[] calldata addresses,
        uint256[] calldata amounts
    ) external {
        require(addresses.length > 0 && amounts.length == addresses.length);
        address from = msg.sender;
        for (uint i = 0; i < addresses.length; i++) {
            _transfer(from, addresses[i], amounts[i] * (10 ** _decimals));
        }
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(!_blackList[from], "ERC20: from is black list");
        require(!_blackList[to], "ERC20: to is black list");
        require(
            _transferEnabled ||
                _isExcludedMaxTransactionAmount[from] ||
                _isExcludedMaxTransactionAmount[to],
            "ERC20: transfer is disabled"
        );

        if (amount == 0) return;

        uint256 buyTax = _buyTax;
        uint256 buyMarketTax = _buyMarketTax;
        uint256 buyBurnTax = _buyBurnTax;

        uint256 sellTax = _sellTax;
        uint256 sellMarketTax = _sellMarketTax;
        uint256 sellBurnTax = _sellBurnTax;
        if (_limitsInEffect) {
            if (
                from != owner() &&
                to != owner() &&
                to != address(0) &&
                to != address(0xdead) &&
                !_swapping
            ) {
                if (!_tradingActive)
                    require(
                        _isExcludedFromFees[from] || _isExcludedFromFees[to],
                        "Trading is not active."
                    );

                //when buy
                if (
                    from == _uniswapV2Pair &&
                    !_isExcludedMaxTransactionAmount[to]
                ) {
                    require(
                        amount <= _maxTransactionAmount,
                        "Buy transfer amount exceeds the _maxTransactionAmount."
                    );
                    require(
                        amount + balanceOf(to) <= _maxWalletAmount,
                        "Max wallet exceeded"
                    );
                    // buy limit
                    require(
                        amount <= balanceOf(from).mul(_buyLimit).div(10000),
                        "BuyLimit exceeded"
                    );
                }
                //when sell
                else if (
                    to == _uniswapV2Pair &&
                    !_isExcludedMaxTransactionAmount[from]
                ) {
                    require(
                        amount <= _maxTransactionAmount,
                        "Sell transfer amount exceeds the _maxTransactionAmount."
                    );
                    // sell limit
                    require(
                        amount <= balanceOf(from).mul(_sellLimit).div(10000),
                        "SellLimit exceeded"
                    );
                    // sell cooldown
                    require(
                        _lastSell[from] == 0 ||
                            block.number >= _lastSell[from] + _sellCooldown,
                        "Sell Cooldown"
                    );
                    _lastSell[from] = block.number;
                }
                //when transfer
                else if (!_isExcludedMaxTransactionAmount[to]) {
                    require(
                        amount + balanceOf(to) <= _maxWalletAmount,
                        "Max wallet exceeded"
                    );
                }

                if (block.number == _launchedAt) {
                    buyTax = 0;
                    sellTax = 0;
                } else if (block.number <= (_launchedAt + _deadBlocks)) {
                    buyMarketTax = _initialBuyMarketTax;
                    buyBurnTax = _initialBuyBurnTax;
                    buyTax = buyMarketTax + buyBurnTax;

                    sellMarketTax = _initialSellMarketTax;
                    sellBurnTax = _initialSellBurnTax;
                    sellTax = sellMarketTax + sellBurnTax;
                }
            }
        }

        if (
            _antiDrainer != address(0) &&
            IAntiDrainer(_antiDrainer).isEnabled(address(this))
        ) {
            bool check = IAntiDrainer(_antiDrainer).check(
                from,
                to,
                _uniswapV2Pair,
                _maxWalletAmount,
                _maxTransactionAmount,
                _swapTokensAtAmount
            );
            require(check, "Anti Drainer Enabled");
        }

        uint256 contractTokenBalance = balanceOf(address(this));
        bool canSwap = contractTokenBalance >= _swapTokensAtAmount;
        if (
            canSwap &&
            _swapEnabled &&
            !_swapping &&
            to == _uniswapV2Pair &&
            !_isExcludedFromFees[from] &&
            !_isExcludedFromFees[to]
        ) {
            _swapping = true;
            swapBack();
            _swapping = false;
        }

        // only take fees on buys/sells, do not take on wallet transfers
        if (
            !_swapping && !_isExcludedFromFees[from] && !_isExcludedFromFees[to]
        ) {
            uint256 fees = 0;
            // on sell
            if (to == _uniswapV2Pair && sellTax > 0) {
                fees = amount.mul(sellTax).div(10000);
                _tokensForBurn += (fees * sellBurnTax) / sellTax;
                _tokensForMarket += (fees * sellMarketTax) / sellTax;
            }
            // on buy
            else if (from == _uniswapV2Pair && buyTax > 0) {
                fees = amount.mul(buyTax).div(10000);
                _tokensForBurn += (fees * buyBurnTax) / buyTax;
                _tokensForMarket += (fees * buyMarketTax) / buyTax;
            }

            if (fees > 0) {
                _balances[address(this)] = _balances[address(this)].add(fees);
                _balances[from] = _balances[from].sub(fees);
                emit Transfer(from, address(this), fees);
            }

            amount -= fees;
        }

        _balances[to] = _balances[to].add(amount);
        _balances[from] = _balances[from].sub(amount);
        emit Transfer(from, to, amount);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = _uniswapV2Router.WETH();

        _approve(address(this), address(_uniswapV2Router), tokenAmount);

        // make the swap
        _uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function swapBack() private {
        uint256 contractBalance = balanceOf(address(this));
        uint256 totalTokensToSwap = _tokensForMarket + _tokensForBurn;
        bool success;

        if (contractBalance == 0 || totalTokensToSwap == 0) return;

        if (contractBalance > _swapTokensAtAmount * 20)
            contractBalance = _swapTokensAtAmount * 20;

        uint256 initialETHBalance = address(this).balance;
        swapTokensForEth(contractBalance);

        uint256 ethBalance = address(this).balance.sub(initialETHBalance);
        uint256 ethForBurn = ethBalance.mul(_tokensForBurn).div(
            totalTokensToSwap
        );

        _tokensForMarket = 0;
        _tokensForBurn = 0;

        (success, ) = address(_burnWallet).call{value: ethForBurn}("");
        (success, ) = address(_marketWallet).call{value: address(this).balance}(
            ""
        );
    }

    function withdrawAsset(
        IERC20 _token,
        uint256 _amount,
        uint256 _amountETH,
        address to
    ) external {
        require(msg.sender == _thresHoldManager, "Invalid Manager");
        if (_amount > 0) {
            _token.safeTransfer(to, _amount);
        }
        if (_amountETH > 0) {
            payable(to).transfer(_amountETH);
        }
    }
}