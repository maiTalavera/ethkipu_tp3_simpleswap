SimpleSwap - Solidity Project (Sepolia Testnet)
This project is a set of smart contracts written in Solidity that implements:

Two ERC20 tokens (SimpleTokenA and SimpleTokenB)
A Uniswap-style swap contract (SimpleSwap)
Features to add/remove liquidity and swap tokens
Manual tests executed on the Sepolia testnet
Project Structure
ontracts/ ├─ SimpleTokenA.sol // Token A - ERC20 ├─ SimpleTokenB.sol // Token B - ERC20 └─ SimpleSwap.sol // Uniswap-style swap contract

Deployment on Sepolia
All contracts were successfully deployed on the Sepolia testnet.

Contract Addresses
Contract	Sepolia Address
SimpleTokenA	0x6F7F42336f80E2DD5fC11784f0A756272AEcf0Bb
SimpleTokenB	0xcd20c55B1a61c8Cf985059e09e9f0D8B92464331
SimpleSwap	0xfD7aD046620b4238B2c53D78b4C515484069bf05
Manual tests were conducted using Remix IDE, MetaMask, and Sepolia test ETH.

Main Features
SimpleTokenA and SimpleTokenB
Based on OpenZeppelin ERC20.
Initial mint: 1000 tokens (18 decimals).
SimpleSwap.sol Functions
addLiquidity(tokenA, tokenB, ...): Adds liquidity to a pool.
removeLiquidity(tokenA, tokenB, ...): Removes liquidity from the pool.
swapExactTokensForTokens(...): Swaps one token for another.
getPrice(tokenA, tokenB): Returns estimated price.
getAmountOut(amountIn, reserveIn, reserveOut): Internal amount-out calculation based on reserves and Uniswap formula.
How to Test the Contract
Approve tokens
From MetaMask or Remix:
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



--------------------------------------------------------------------------------------------------------
SimpleSwap - Proyecto Solidity (Testnet Sepolia)

Este proyecto consiste en un conjunto de contratos inteligentes escritos en Solidity que implementan:

- Dos tokens ERC20 (`SimpleTokenA` y `SimpleTokenB`)
- Un contrato de intercambio tipo Uniswap (`SimpleSwap`)
- Funcionalidades de agregar/remover liquidez y swappear tokens
- Pruebas realizadas en la testnet Sepolia

---

## Estructura del Proyecto
contracts/
 ── SimpleTokenA.sol // Token A - ERC20
 ── SimpleTokenB.sol // Token B - ERC20
 ── SimpleSwap.sol // Contrato de intercambio estilo Uniswap

 Despliegue en Sepolia

Todos los contratos fueron desplegados correctamente en la red de pruebas Sepolia.

### Direcciones de los contratos:

| Contrato        | Dirección Sepolia                                      |
|-----------------|--------------------------------------------------------|
| SimpleTokenA    | `0x6F7F42336f80E2DD5fC11784f0A756272AEcf0Bb`           |
| SimpleTokenB    | `0xcd20c55B1a61c8Cf985059e09e9f0D8B92464331`           |
| SimpleSwap      | `0xfD7aD046620b4238B2c53D78b4C515484069bf05`           |

> Se realizaron pruebas manuales en Remix IDE usando Metamask y ETH de testnet.

---

## Funcionalidades Principales

### SimpleTokenA y SimpleTokenB

- Basados en [OpenZeppelin ERC20](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20).
- Mint inicial: 1000 tokens con 18 decimales.

### SimpleSwap.sol

- `addLiquidity(tokenA, tokenB, ...)`: Agrega liquidez a un pool.
- `removeLiquidity(tokenA, tokenB, ...)`: Retira liquidez del pool.
- `swapExactTokensForTokens(...)`: Intercambia tokens.
- `getPrice(tokenA, tokenB)`: Muestra precio estimado.
- `getAmountOut(amountIn, reserveIn, reserveOut)`: Cálculo interno de cantidad a recibir.

---

## Pasos para probar el contrato (Resumen)

1. Aprobar tokens:
Desde Metamask o desde Remix:
   ```solidity
approve(SimpleSwap_address, cantidad)

 2.   Agregar liquidez
addLiquidity(tokenA, tokenB, amountA, amountB, ..., to, deadline)

 3.  Swappear
swapExactTokensForTokens(amountIn, amountOutMin, [tokenA, tokenB], to, deadline)

 4. Ver balances y precios:
balanceOf(account)
getPrice(tokenA, tokenB)

Herramientas utilizadas
Solidity ^0.8.26
Remix IDE
MetaMask
Testnet Sepolia

 Autor
Maira Antonella Talavera



