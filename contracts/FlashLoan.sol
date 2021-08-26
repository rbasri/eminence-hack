pragma solidity ^0.7.0;

import "hardhat/console.sol";
import { FlashLoanReceiverBase } from "@aave/protocol-v2/contracts/flashloan/base/FlashLoanReceiverBase.sol";
import { ILendingPool } from "@aave/protocol-v2/contracts/interfaces/ILendingPool.sol";
import { ILendingPoolAddressesProvider } from "@aave/protocol-v2/contracts/interfaces/ILendingPoolAddressesProvider.sol";
import { IERC20 } from "./IERC20.sol";


contract FlashLoan is FlashLoanReceiverBase {

    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    )
        external
        override
        returns (bool)
    {

        //
        // This contract now has the funds requested.
        // Your logic goes here.
        //
        
        // At the end of your logic above, this contract owes
        // the flashloaned amounts + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.
        
        // Approve the LendingPool contract allowance to *pull* the owed amount
        for (uint i = 0; i < assets.length; i++) {
            uint amountOwing = amounts[i].add(premiums[i]);
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }
        
        return true;
    }
    
    function myFlashLoanCall() public {
        address receiverAddress = address(this);

        address[] memory assets = new address[](2);
        assets[0] = address(INSERT_ASSET_ONE_ADDRESS);
        // assets[1] = address(INSERT_ASSET_TWO_ADDRESS);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = INSERT_ASSET_ONE_AMOUNT;
        // amounts[1] = INSERT_ASSET_TWO_AMOUNT;

        // 0 = no debt, 1 = stable, 2 = variable
        uint256[] memory modes = new uint256[](2);
        modes[0] = 1;
        // modes[1] = INSERT_ASSET_TWO_MODE;

        address onBehalfOf = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        LENDING_POOL.flashLoan(
            receiverAddress,
            assets,
            amounts,
            modes,
            onBehalfOf,
            params,
            referralCode
        );
    }
}