# SimpleSwap - Solidity Project (Sepolia Testnet)

This project is a set of smart contracts written in Solidity that implements:

- Two ERC20 tokens (`SimpleTokenA` and `SimpleTokenB`)
- A Uniswap-style swap contract (`SimpleSwap`)
- Features to add/remove liquidity and swap tokens
- Manual tests executed on the Sepolia testnet

---

## Project Structure

ontracts/
├─ SimpleTokenA.sol // Token A - ERC20
├─ SimpleTokenB.sol // Token B - ERC20
└─ SimpleSwap.sol // Uniswap-style swap contract

---

##  Deployment on Sepolia

All contracts were successfully deployed on the Sepolia testnet.

###  Contract Addresses

| Contract       | Sepolia Address                                        |
|----------------|--------------------------------------------------------|
| SimpleTokenA   | `0x6F7F42336f80E2DD5fC11784f0A756272AEcf0Bb`           |
| SimpleTokenB   | `0xcd20c55B1a61c8Cf985059e09e9f0D8B92464331`           |
| SimpleSwap     | `0xfD7aD046620b4238B2c53D78b4C515484069bf05`           |

> Manual tests were conducted using Remix IDE, MetaMask, and Sepolia test ETH.

---

## Main Features

### `SimpleTokenA` and `SimpleTokenB`

- Based on [OpenZeppelin ERC20](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20).
- Initial mint: 1000 tokens (18 decimals).

### `SimpleSwap.sol` Functions

- `addLiquidity(tokenA, tokenB, ...)`: Adds liquidity to a pool.
- `removeLiquidity(tokenA, tokenB, ...)`: Removes liquidity from the pool.
- `swapExactTokensForTokens(...)`: Swaps one token for another.
- `getPrice(tokenA, tokenB)`: Returns estimated price.
- `getAmountOut(amountIn, reserveIn, reserveOut)`: Internal amount-out calculation based on reserves and Uniswap formula.

---

##  How to Test the Contract 

1.  **Approve tokens**  
From MetaMask or Remix:
   ```solidity
   approve(SimpleSwap_address, amount)
Add Liquidity
addLiquidity(tokenA, tokenB, amountA, amountB, ..., to, deadline)
 
 Swap Tokens
swapExactTokensForTokens(amountIn, amountOutMin, [tokenA, tokenB], to, deadline)

Check Balances and Prices
balanceOf(account)
getPrice(tokenA, tokenB)

Tools Used
Solidity ^0.8.26
Remix IDE
MetaMask
Sepolia Testnet

 Author
Maira Antonella Talavera