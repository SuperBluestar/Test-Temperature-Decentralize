// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/Context.sol";

struct ITemp {
    uint16 temp;
    uint16 longitude;
    uint16 latitude;
}

contract Temperature is Context {
    event Added(uint64 id,address indexed setter, uint16 longitude, uint16 latitude);
    address private _oracle;
    modifier onlyOracle() {
        require(_oracle == _msgSender(), "Caller is not the oracle");
        _;
    }

    constructor(address oracle_) {
        require(oracle_ != address(0), "Oracle cannot be zero address");
        _oracle = oracle_;
    }

    function decimal() public pure returns(uint8) {
        return 2;
    }

    ITemp[] private _list;
    function setter(uint16 temp_, uint16 longitude_, uint16 latitude_) external {
        ITemp memory iTemp = ITemp(temp_, longitude_, latitude_);
        _list.push(iTemp);

        emit Added(uint64(_list.length) - 1, _msgSender(), longitude_, latitude_);
    }

    function remove(uint index_) external onlyOracle {
        if (index_ >= _list.length) return;

        for (uint i = index_; i < _list.length - 1; i++){
            _list[i] = _list[i+1];
        }
        delete _list[_list.length-1];
    }

    function getter() external view returns(uint16) {
        uint256 sum_ = 0;
        for (uint64 i = 0; i < _list.length; i ++) {
            sum_ += _list[i].temp;
        }
        return uint16(uint256(sum_) / uint256(_list.length));
    }
}